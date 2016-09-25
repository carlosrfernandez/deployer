package main

import (
    "flag"
    "os"
    "github.com/aws/aws-sdk-go/aws"
    "github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/ec2"
    "text/template"
    "fmt"
    "time"
    "errors"
)

func Describe(serve bool) (r int) {
    if (serve) {
        _test("td0", "eu-west-1", "notisdev", "ci.corp")
    } else {
        describeCommand := flag.NewFlagSet("describe", flag.ExitOnError)
        id := describeCommand.String("id", "", "The environment id to describe")
        describeCommand.Parse(os.Args[2:])

        if describeCommand.Parsed() {
            if *id == "" {
                _usage()
                return 1
            }
            _test(*id, "eu-west-1", "notisdev", "ci.corp")
        }
    }

    return 0
}

func _usage() {
    multilinePrint(
        " ",
        "USAGE:",
        " .\\devops.ps1 describe -i|id NAME [options]",
        " ",
        " Mandatory:",
        "   -i|id     A string id to distinct your unit, it must only contains alphanumeric characters",
        " ",
        " Examples:",
        "   - .\\devops.ps1 describe -id environment",
        " ")
}

func _test(id string, region string, vpc string, domain string) {
    instanceDescriptions := _getEnvironmentInstances(id, region)
    elements := _organiseData(instanceDescriptions, id, vpc, domain)
    _printDescription(elements)
}

func _organiseData(instanceDescriptions *ec2.DescribeInstancesOutput, id string, vpc string, domain string) (organisedData *[]Description) {
    elements := []Description{}
    for _,reservation := range instanceDescriptions.Reservations{
        for _,instance := range reservation.Instances{
            serviceName,err := _tagValue(instance.Tags,"Name")
            check(err)

            state,err := _tagValue(instance.Tags,"State")
            check(err)

            version,err := _tagValue(instance.Tags,"Version")
            check(err)

            elements = append(
                elements,
                Description{
                    serviceName,
                    *instance.PrivateIpAddress,
                    *instance.State.Name,
                    state,
                    version,
                    fmt.Sprintf("%s-%s.%s.%s", serviceName,id,vpc,domain),
                    instance.LaunchTime.Format(time.UnixDate),
                })
            check(err)
        }
    }
    organisedData = &elements
    return
}

func _getEnvironmentInstances(id string, region string) (instanceDescriptions *ec2.DescribeInstancesOutput) {
    sess, err := session.NewSession()
    check(err)

    svc := ec2.New(sess, aws.NewConfig().WithRegion(region))
    params := &ec2.DescribeInstancesInput{
        Filters: []*ec2.Filter{
            {
                Name: aws.String("tag:Environment"),
                Values: []*string{
                    aws.String(id),
                },
            },
        },
    }
    instanceDescriptions, err = svc.DescribeInstances(params)
    check(err)
    return
}

func _tagValue (tags []*ec2.Tag, search string) (value string, err error) {
    value,err = "",errors.New("Key not found")

    for _, tag := range tags {
        if (*tag.Key == search) {
            return *tag.Value,nil
        }
    }
    return
}

func _printDescription(elements *[]Description) {
    tmpl := template.New("template")
    tmpl, err := tmpl.ParseFiles("template")
    check(err)

    err = tmpl.Execute(os.Stdout, elements)
    check(err)
}
