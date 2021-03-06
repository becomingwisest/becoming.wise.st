---
layout: post
title:  "Silly Lambda"
date:   2020-05-30 13:50:00 -0700
---

I decided to have some fun with lambda today. Something to do 99 root beers.

```
import json
import boto3

def lambda_handler(event, context):
    # TODO implement
    client = boto3.client('lambda')
    count = event['rootbeers']

    if count > 0:
        if count > 1:
            bottles = '{} bottles of rootbeer.'
        else:
            bottles = '{} bottle of rootbeer.'
        print(bottles.format(count))
        response = client.invoke(
            FunctionName=context.function_name,
            InvocationType='Event',
            Qualifier=context.function_version,
            Payload=json.dumps({'rootbeers': count-1})
        )
    else:
        print("All gone.")

    return {
        'statusCode': 200,
        'body': json.dumps({context.function_name: context.function_version})
    }
```

Lets test this out. It seems I need to specify an outfile, so `-` for standard output. [aws cli docs](https://docs.aws.amazon.com/cli/latest/reference/lambda/invoke.html)
```
root@196c6175b6bc:/repos/aws-auto# aws lambda invoke --function-name 'rootbeerpy' --payload '{"rootbeers":99}'
usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
To see help text, you can run:

  aws help
  aws <command> help
  aws <command> <subcommand> help
aws: error: the following arguments are required: outfile
root@196c6175b6bc:/repos/aws-auto# aws lambda invoke --function-name 'rootbeerpy' --payload '{"rootbeers":99}' -
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
root@196c6175b6bc:/repos/aws-auto#
```

I'm going to cheat, and lookup the log stream I need from [my aws console](https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#logsV2:log-groups/log-group/$252Faws$252Flambda$252Frootbeerpy)

```
root@196c6175b6bc:/repos/aws-auto# aws logs get-log-events --log-group-name /aws/lambda/rootbeerpy --log-stream-name '2020/05/30/[$LATEST]894a616df60745a59319f13594d8fdc1'
{
    "events": [
        {
            "timestamp": 1590877400620,
            "message": "START RequestId: f2516ce3-bf6a-4132-8188-9a2c6f8c9bb5 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401363,
            "message": "99 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401623,
            "message": "END RequestId: f2516ce3-bf6a-4132-8188-9a2c6f8c9bb5\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401623,
            "message": "REPORT RequestId: f2516ce3-bf6a-4132-8188-9a2c6f8c9bb5\tDuration: 1002.82 ms\tBilled Duration: 1100 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\tInit Duration: 293.65 ms\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401654,
            "message": "START RequestId: 222c6003-2404-4816-a23c-67bfcc254684 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401660,
            "message": "98 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401843,
            "message": "END RequestId: 222c6003-2404-4816-a23c-67bfcc254684\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401843,
            "message": "REPORT RequestId: 222c6003-2404-4816-a23c-67bfcc254684\tDuration: 186.40 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401859,
            "message": "START RequestId: 664e5c13-7f49-4535-870e-7027c0a4319c Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877401865,
            "message": "97 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402123,
            "message": "END RequestId: 664e5c13-7f49-4535-870e-7027c0a4319c\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402123,
            "message": "REPORT RequestId: 664e5c13-7f49-4535-870e-7027c0a4319c\tDuration: 261.06 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402144,
            "message": "START RequestId: 1d5c207f-6ecf-45d5-ac11-a34e0a470467 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402163,
            "message": "96 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402343,
            "message": "END RequestId: 1d5c207f-6ecf-45d5-ac11-a34e0a470467\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402343,
            "message": "REPORT RequestId: 1d5c207f-6ecf-45d5-ac11-a34e0a470467\tDuration: 195.80 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402382,
            "message": "START RequestId: 84f2b108-c17b-48fd-a428-50e112b5bde3 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402405,
            "message": "95 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402603,
            "message": "END RequestId: 84f2b108-c17b-48fd-a428-50e112b5bde3\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402603,
            "message": "REPORT RequestId: 84f2b108-c17b-48fd-a428-50e112b5bde3\tDuration: 218.83 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402608,
            "message": "START RequestId: 2be85885-8ca0-43b6-89a6-175cbf340cdb Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402643,
            "message": "94 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402823,
            "message": "END RequestId: 2be85885-8ca0-43b6-89a6-175cbf340cdb\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402823,
            "message": "REPORT RequestId: 2be85885-8ca0-43b6-89a6-175cbf340cdb\tDuration: 211.95 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402837,
            "message": "START RequestId: 165da551-f037-44a1-b672-c0c92ce52ae0 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877402863,
            "message": "93 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403073,
            "message": "END RequestId: 165da551-f037-44a1-b672-c0c92ce52ae0\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403073,
            "message": "REPORT RequestId: 165da551-f037-44a1-b672-c0c92ce52ae0\tDuration: 233.02 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403086,
            "message": "START RequestId: 242099f7-40ab-4d57-be4e-2577b59db55a Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403093,
            "message": "92 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403343,
            "message": "END RequestId: 242099f7-40ab-4d57-be4e-2577b59db55a\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403343,
            "message": "REPORT RequestId: 242099f7-40ab-4d57-be4e-2577b59db55a\tDuration: 254.18 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403363,
            "message": "START RequestId: 2bce73e9-c6bc-4898-a30c-17abe0ca28a2 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403370,
            "message": "91 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403633,
            "message": "END RequestId: 2bce73e9-c6bc-4898-a30c-17abe0ca28a2\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403633,
            "message": "REPORT RequestId: 2bce73e9-c6bc-4898-a30c-17abe0ca28a2\tDuration: 267.67 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403638,
            "message": "START RequestId: 47ffcb01-f01a-4e98-82e4-5fc3902a5220 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403645,
            "message": "90 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403883,
            "message": "END RequestId: 47ffcb01-f01a-4e98-82e4-5fc3902a5220\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403883,
            "message": "REPORT RequestId: 47ffcb01-f01a-4e98-82e4-5fc3902a5220\tDuration: 241.38 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403896,
            "message": "START RequestId: 1592f18d-7e3c-4441-a8e0-98d168391c8e Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877403942,
            "message": "89 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404103,
            "message": "END RequestId: 1592f18d-7e3c-4441-a8e0-98d168391c8e\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404103,
            "message": "REPORT RequestId: 1592f18d-7e3c-4441-a8e0-98d168391c8e\tDuration: 204.75 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404134,
            "message": "START RequestId: 65b5666e-c809-492e-8d17-54383832bcaf Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404141,
            "message": "88 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404363,
            "message": "END RequestId: 65b5666e-c809-492e-8d17-54383832bcaf\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404363,
            "message": "REPORT RequestId: 65b5666e-c809-492e-8d17-54383832bcaf\tDuration: 225.78 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404381,
            "message": "START RequestId: 9ed334fe-0f3b-4699-9dfc-6a46c911a585 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404404,
            "message": "87 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404603,
            "message": "END RequestId: 9ed334fe-0f3b-4699-9dfc-6a46c911a585\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404603,
            "message": "REPORT RequestId: 9ed334fe-0f3b-4699-9dfc-6a46c911a585\tDuration: 218.99 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404608,
            "message": "START RequestId: 4da3fe52-547a-4828-bb26-cb667d07ce44 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404643,
            "message": "86 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404804,
            "message": "END RequestId: 4da3fe52-547a-4828-bb26-cb667d07ce44\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404804,
            "message": "REPORT RequestId: 4da3fe52-547a-4828-bb26-cb667d07ce44\tDuration: 192.65 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404826,
            "message": "START RequestId: 0ec933a5-dff2-4bc8-886a-fb0ec8e28946 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877404846,
            "message": "85 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405103,
            "message": "END RequestId: 0ec933a5-dff2-4bc8-886a-fb0ec8e28946\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405103,
            "message": "REPORT RequestId: 0ec933a5-dff2-4bc8-886a-fb0ec8e28946\tDuration: 274.57 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405123,
            "message": "START RequestId: 502b082f-e8c1-4d36-96e9-3708cdc67dc0 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405129,
            "message": "84 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405303,
            "message": "END RequestId: 502b082f-e8c1-4d36-96e9-3708cdc67dc0\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405303,
            "message": "REPORT RequestId: 502b082f-e8c1-4d36-96e9-3708cdc67dc0\tDuration: 177.41 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405326,
            "message": "START RequestId: 1ba5436e-d965-4cb4-a798-fd5da4e1f3da Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405344,
            "message": "83 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405523,
            "message": "END RequestId: 1ba5436e-d965-4cb4-a798-fd5da4e1f3da\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405523,
            "message": "REPORT RequestId: 1ba5436e-d965-4cb4-a798-fd5da4e1f3da\tDuration: 194.49 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405545,
            "message": "START RequestId: 6b477b1a-fbf8-4de0-b4b4-29537eaf519c Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405564,
            "message": "82 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405763,
            "message": "END RequestId: 6b477b1a-fbf8-4de0-b4b4-29537eaf519c\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405763,
            "message": "REPORT RequestId: 6b477b1a-fbf8-4de0-b4b4-29537eaf519c\tDuration: 215.05 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405781,
            "message": "START RequestId: 7090d4bc-67f7-4f8f-a737-a649a1717009 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405803,
            "message": "81 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405983,
            "message": "END RequestId: 7090d4bc-67f7-4f8f-a737-a649a1717009\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877405983,
            "message": "REPORT RequestId: 7090d4bc-67f7-4f8f-a737-a649a1717009\tDuration: 199.64 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406006,
            "message": "START RequestId: 2b998c7c-665c-47b3-80d6-839bdcdbc53f Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406024,
            "message": "80 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406183,
            "message": "END RequestId: 2b998c7c-665c-47b3-80d6-839bdcdbc53f\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406183,
            "message": "REPORT RequestId: 2b998c7c-665c-47b3-80d6-839bdcdbc53f\tDuration: 174.86 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406209,
            "message": "START RequestId: 3726dc8a-00d6-4d29-afc3-d3797cde9eef Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406224,
            "message": "79 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406424,
            "message": "END RequestId: 3726dc8a-00d6-4d29-afc3-d3797cde9eef\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406424,
            "message": "REPORT RequestId: 3726dc8a-00d6-4d29-afc3-d3797cde9eef\tDuration: 211.07 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406433,
            "message": "START RequestId: 4dbf3e07-afe0-41d8-8ca0-5465a4a67972 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406464,
            "message": "78 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406643,
            "message": "END RequestId: 4dbf3e07-afe0-41d8-8ca0-5465a4a67972\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406643,
            "message": "REPORT RequestId: 4dbf3e07-afe0-41d8-8ca0-5465a4a67972\tDuration: 207.34 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406648,
            "message": "START RequestId: dc78c4af-b2b6-4b00-9de5-911d1b3f7008 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406703,
            "message": "77 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406883,
            "message": "END RequestId: dc78c4af-b2b6-4b00-9de5-911d1b3f7008\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406883,
            "message": "REPORT RequestId: dc78c4af-b2b6-4b00-9de5-911d1b3f7008\tDuration: 232.45 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406901,
            "message": "START RequestId: 9580d9bb-d964-4395-8de5-f5d61566081e Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877406923,
            "message": "76 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407106,
            "message": "END RequestId: 9580d9bb-d964-4395-8de5-f5d61566081e\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407106,
            "message": "REPORT RequestId: 9580d9bb-d964-4395-8de5-f5d61566081e\tDuration: 202.29 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407129,
            "message": "START RequestId: 41038dbf-5048-43e0-aa83-f9b5550df290 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407144,
            "message": "75 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407324,
            "message": "END RequestId: 41038dbf-5048-43e0-aa83-f9b5550df290\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407324,
            "message": "REPORT RequestId: 41038dbf-5048-43e0-aa83-f9b5550df290\tDuration: 191.15 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407343,
            "message": "START RequestId: f45b92e3-4238-4791-95cc-950be82cd888 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407349,
            "message": "74 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407544,
            "message": "END RequestId: f45b92e3-4238-4791-95cc-950be82cd888\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407544,
            "message": "REPORT RequestId: f45b92e3-4238-4791-95cc-950be82cd888\tDuration: 198.15 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407570,
            "message": "START RequestId: 51cd33ce-d575-4df3-8bd9-4186b1124117 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407576,
            "message": "73 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407783,
            "message": "END RequestId: 51cd33ce-d575-4df3-8bd9-4186b1124117\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407783,
            "message": "REPORT RequestId: 51cd33ce-d575-4df3-8bd9-4186b1124117\tDuration: 210.28 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407807,
            "message": "START RequestId: 7996d33d-04a7-4c03-ac23-b59a834de333 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877407813,
            "message": "72 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408003,
            "message": "END RequestId: 7996d33d-04a7-4c03-ac23-b59a834de333\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408003,
            "message": "REPORT RequestId: 7996d33d-04a7-4c03-ac23-b59a834de333\tDuration: 193.32 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408031,
            "message": "START RequestId: 4ac1f1b1-4c3a-4478-a531-a76854b4d2b6 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408037,
            "message": "71 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408223,
            "message": "END RequestId: 4ac1f1b1-4c3a-4478-a531-a76854b4d2b6\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408223,
            "message": "REPORT RequestId: 4ac1f1b1-4c3a-4478-a531-a76854b4d2b6\tDuration: 189.06 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408247,
            "message": "START RequestId: 0a27f13d-526f-4cd7-bd54-16bcc6b211e9 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408254,
            "message": "70 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408503,
            "message": "END RequestId: 0a27f13d-526f-4cd7-bd54-16bcc6b211e9\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408503,
            "message": "REPORT RequestId: 0a27f13d-526f-4cd7-bd54-16bcc6b211e9\tDuration: 252.91 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408520,
            "message": "START RequestId: de48aab0-1b93-4eb9-82af-b33cd8d31c3b Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408563,
            "message": "69 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408764,
            "message": "END RequestId: de48aab0-1b93-4eb9-82af-b33cd8d31c3b\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408764,
            "message": "REPORT RequestId: de48aab0-1b93-4eb9-82af-b33cd8d31c3b\tDuration: 240.50 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408789,
            "message": "START RequestId: bd0d1222-9c0f-468e-8cad-d120f19fe0fd Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408804,
            "message": "68 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408983,
            "message": "END RequestId: bd0d1222-9c0f-468e-8cad-d120f19fe0fd\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877408983,
            "message": "REPORT RequestId: bd0d1222-9c0f-468e-8cad-d120f19fe0fd\tDuration: 191.21 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409006,
            "message": "START RequestId: 4831883b-b066-4adb-873e-9cf7fd719399 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409013,
            "message": "67 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409203,
            "message": "END RequestId: 4831883b-b066-4adb-873e-9cf7fd719399\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409203,
            "message": "REPORT RequestId: 4831883b-b066-4adb-873e-9cf7fd719399\tDuration: 193.83 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409235,
            "message": "START RequestId: 2722c41f-90d3-4416-9ad0-447ac5f54116 Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409263,
            "message": "66 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409423,
            "message": "END RequestId: 2722c41f-90d3-4416-9ad0-447ac5f54116\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409423,
            "message": "REPORT RequestId: 2722c41f-90d3-4416-9ad0-447ac5f54116\tDuration: 184.91 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409428,
            "message": "START RequestId: fa4c8ab1-0ba4-4cd7-81c4-df4a9e575cef Version: $LATEST\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409434,
            "message": "65 bottles of rootbeer.\n",
            "ingestionTime": 1590877409637
        },
        {
            "timestamp": 1590877409663,
            "message": "END RequestId: fa4c8ab1-0ba4-4cd7-81c4-df4a9e575cef\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877409663,
            "message": "REPORT RequestId: fa4c8ab1-0ba4-4cd7-81c4-df4a9e575cef\tDuration: 232.01 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877409691,
            "message": "START RequestId: f487145b-2c0b-433d-8d1c-ccea3d3aa148 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877409783,
            "message": "64 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877409963,
            "message": "END RequestId: f487145b-2c0b-433d-8d1c-ccea3d3aa148\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877409963,
            "message": "REPORT RequestId: f487145b-2c0b-433d-8d1c-ccea3d3aa148\tDuration: 195.82 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410003,
            "message": "START RequestId: ba3ca9dc-a5b3-4275-8b21-3500be7d6888 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410008,
            "message": "63 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410221,
            "message": "END RequestId: ba3ca9dc-a5b3-4275-8b21-3500be7d6888\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410221,
            "message": "REPORT RequestId: ba3ca9dc-a5b3-4275-8b21-3500be7d6888\tDuration: 215.92 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410251,
            "message": "START RequestId: bc936b81-9b71-4b3a-92a9-0fa3f58c7033 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410257,
            "message": "62 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410463,
            "message": "END RequestId: bc936b81-9b71-4b3a-92a9-0fa3f58c7033\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410463,
            "message": "REPORT RequestId: bc936b81-9b71-4b3a-92a9-0fa3f58c7033\tDuration: 209.08 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410467,
            "message": "START RequestId: 8415cb26-b769-4037-8bfb-bf44540982e8 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410473,
            "message": "61 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410683,
            "message": "END RequestId: 8415cb26-b769-4037-8bfb-bf44540982e8\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410683,
            "message": "REPORT RequestId: 8415cb26-b769-4037-8bfb-bf44540982e8\tDuration: 213.77 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410698,
            "message": "START RequestId: 2bba63d3-cfea-4b9d-bc91-462572909d24 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410704,
            "message": "60 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410903,
            "message": "END RequestId: 2bba63d3-cfea-4b9d-bc91-462572909d24\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410903,
            "message": "REPORT RequestId: 2bba63d3-cfea-4b9d-bc91-462572909d24\tDuration: 202.55 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410906,
            "message": "START RequestId: 381e0374-5b5e-4675-b794-e11433f859ff Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877410925,
            "message": "59 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411098,
            "message": "END RequestId: 381e0374-5b5e-4675-b794-e11433f859ff\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411098,
            "message": "REPORT RequestId: 381e0374-5b5e-4675-b794-e11433f859ff\tDuration: 188.81 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411125,
            "message": "START RequestId: c0b62e36-b904-4100-ad01-05e356d90a41 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411144,
            "message": "58 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411323,
            "message": "END RequestId: c0b62e36-b904-4100-ad01-05e356d90a41\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411323,
            "message": "REPORT RequestId: c0b62e36-b904-4100-ad01-05e356d90a41\tDuration: 195.15 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411328,
            "message": "START RequestId: a7bdd3ce-bffc-4ea7-82e9-caf465157207 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411363,
            "message": "57 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411524,
            "message": "END RequestId: a7bdd3ce-bffc-4ea7-82e9-caf465157207\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411524,
            "message": "REPORT RequestId: a7bdd3ce-bffc-4ea7-82e9-caf465157207\tDuration: 193.26 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411549,
            "message": "START RequestId: 8f322a47-86a6-4965-ace2-7c03e90370c4 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411564,
            "message": "56 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411823,
            "message": "END RequestId: 8f322a47-86a6-4965-ace2-7c03e90370c4\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411823,
            "message": "REPORT RequestId: 8f322a47-86a6-4965-ace2-7c03e90370c4\tDuration: 271.14 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411848,
            "message": "START RequestId: c18385b5-f966-446c-8f25-3757ea34ff04 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877411883,
            "message": "55 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412064,
            "message": "END RequestId: c18385b5-f966-446c-8f25-3757ea34ff04\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412064,
            "message": "REPORT RequestId: c18385b5-f966-446c-8f25-3757ea34ff04\tDuration: 212.37 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412066,
            "message": "START RequestId: fafa9caf-7a51-4ee9-8614-f83dba132e8c Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412285,
            "message": "54 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412483,
            "message": "END RequestId: fafa9caf-7a51-4ee9-8614-f83dba132e8c\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412483,
            "message": "REPORT RequestId: fafa9caf-7a51-4ee9-8614-f83dba132e8c\tDuration: 414.61 ms\tBilled Duration: 500 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412490,
            "message": "START RequestId: 3a86ae2d-2bca-4388-a3c9-8c6d51a30ffe Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412504,
            "message": "53 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412683,
            "message": "END RequestId: 3a86ae2d-2bca-4388-a3c9-8c6d51a30ffe\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412683,
            "message": "REPORT RequestId: 3a86ae2d-2bca-4388-a3c9-8c6d51a30ffe\tDuration: 190.49 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412688,
            "message": "START RequestId: 953e35c1-8ac7-420a-9eba-84f4110f7f8d Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412706,
            "message": "52 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412904,
            "message": "END RequestId: 953e35c1-8ac7-420a-9eba-84f4110f7f8d\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412904,
            "message": "REPORT RequestId: 953e35c1-8ac7-420a-9eba-84f4110f7f8d\tDuration: 212.38 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412916,
            "message": "START RequestId: c918e7a8-95ba-43ad-8035-1d5e56d8133e Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877412926,
            "message": "51 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413123,
            "message": "END RequestId: c918e7a8-95ba-43ad-8035-1d5e56d8133e\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413123,
            "message": "REPORT RequestId: c918e7a8-95ba-43ad-8035-1d5e56d8133e\tDuration: 203.31 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413145,
            "message": "START RequestId: b67d3af8-6e75-4f65-9e92-33b1b57171a8 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413163,
            "message": "50 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413343,
            "message": "END RequestId: b67d3af8-6e75-4f65-9e92-33b1b57171a8\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413343,
            "message": "REPORT RequestId: b67d3af8-6e75-4f65-9e92-33b1b57171a8\tDuration: 195.59 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413366,
            "message": "START RequestId: bb02c4fc-91c0-44da-b0f8-d16c04af57f0 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413372,
            "message": "49 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413643,
            "message": "END RequestId: bb02c4fc-91c0-44da-b0f8-d16c04af57f0\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413643,
            "message": "REPORT RequestId: bb02c4fc-91c0-44da-b0f8-d16c04af57f0\tDuration: 274.01 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413668,
            "message": "START RequestId: 107eb12f-d14d-4c1d-8a0e-95198bc16777 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413683,
            "message": "48 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413863,
            "message": "END RequestId: 107eb12f-d14d-4c1d-8a0e-95198bc16777\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877413863,
            "message": "REPORT RequestId: 107eb12f-d14d-4c1d-8a0e-95198bc16777\tDuration: 192.01 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417087,
            "message": "START RequestId: 79265fe4-dd51-4503-bd4a-fccadbf58cff Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417093,
            "message": "36 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417324,
            "message": "END RequestId: 79265fe4-dd51-4503-bd4a-fccadbf58cff\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417324,
            "message": "REPORT RequestId: 79265fe4-dd51-4503-bd4a-fccadbf58cff\tDuration: 234.62 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417348,
            "message": "START RequestId: 68fac4b0-f75b-4ddf-9e2a-10cfb69bd0ad Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417383,
            "message": "35 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417563,
            "message": "END RequestId: 68fac4b0-f75b-4ddf-9e2a-10cfb69bd0ad\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417563,
            "message": "REPORT RequestId: 68fac4b0-f75b-4ddf-9e2a-10cfb69bd0ad\tDuration: 211.90 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417585,
            "message": "START RequestId: f5b3706d-3448-4b6c-8644-b1e923be0ed0 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417603,
            "message": "34 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417823,
            "message": "END RequestId: f5b3706d-3448-4b6c-8644-b1e923be0ed0\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417823,
            "message": "REPORT RequestId: f5b3706d-3448-4b6c-8644-b1e923be0ed0\tDuration: 235.40 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417839,
            "message": "START RequestId: e8b3f55a-cc7e-4bdd-bbff-dea95e80c681 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877417845,
            "message": "33 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418043,
            "message": "END RequestId: e8b3f55a-cc7e-4bdd-bbff-dea95e80c681\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418043,
            "message": "REPORT RequestId: e8b3f55a-cc7e-4bdd-bbff-dea95e80c681\tDuration: 201.34 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418070,
            "message": "START RequestId: 54d0c07d-52ed-488a-8af3-936b0534f082 Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418077,
            "message": "32 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418263,
            "message": "END RequestId: 54d0c07d-52ed-488a-8af3-936b0534f082\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418263,
            "message": "REPORT RequestId: 54d0c07d-52ed-488a-8af3-936b0534f082\tDuration: 190.07 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418286,
            "message": "START RequestId: 230f1e20-34df-4a39-b257-a525733ee28b Version: $LATEST\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418292,
            "message": "31 bottles of rootbeer.\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418483,
            "message": "END RequestId: 230f1e20-34df-4a39-b257-a525733ee28b\n",
            "ingestionTime": 1590877418686
        },
        {
            "timestamp": 1590877418483,
            "message": "REPORT RequestId: 230f1e20-34df-4a39-b257-a525733ee28b\tDuration: 193.95 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 74 MB\t\n",
            "ingestionTime": 1590877418686
        }
    ],
    "nextForwardToken": "f/35477751951685555070150935805019617830171677481933865053",
    "nextBackwardToken": "b/35477751553327343588798414616827746129508945985410564096"
}
root@196c6175b6bc:/repos/aws-auto#
```
```
root@196c6175b6bc:/repos/aws-auto# aws logs get-log-events --log-group-name /aws/lambda/rootbeerpy --log-stream-name '2020/05/30/[$LATEST]385de7efd2a94a379e9cb4fa5bedfde5'
{
    "events": [
        {
            "timestamp": 1590877413849,
            "message": "START RequestId: b44507d2-3213-4665-9534-93c37d598f60 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877414552,
            "message": "47 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877414811,
            "message": "END RequestId: b44507d2-3213-4665-9534-93c37d598f60\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877414811,
            "message": "REPORT RequestId: b44507d2-3213-4665-9534-93c37d598f60\tDuration: 959.83 ms\tBilled Duration: 1000 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\tInit Duration: 255.75 ms\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877414835,
            "message": "START RequestId: bd06cab0-2db8-4201-b297-9f6762cbfcca Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877414841,
            "message": "46 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415031,
            "message": "END RequestId: bd06cab0-2db8-4201-b297-9f6762cbfcca\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415031,
            "message": "REPORT RequestId: bd06cab0-2db8-4201-b297-9f6762cbfcca\tDuration: 193.32 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415052,
            "message": "START RequestId: 287df08e-6588-4a8b-8ba9-e4f3c68296d3 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415091,
            "message": "45 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415291,
            "message": "END RequestId: 287df08e-6588-4a8b-8ba9-e4f3c68296d3\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415291,
            "message": "REPORT RequestId: 287df08e-6588-4a8b-8ba9-e4f3c68296d3\tDuration: 236.03 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415312,
            "message": "START RequestId: 19caaf36-a3ab-48f2-8130-21dc673e0709 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415319,
            "message": "44 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415531,
            "message": "END RequestId: 19caaf36-a3ab-48f2-8130-21dc673e0709\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415531,
            "message": "REPORT RequestId: 19caaf36-a3ab-48f2-8130-21dc673e0709\tDuration: 216.46 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 71 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415535,
            "message": "START RequestId: d0eee81f-b003-4cc9-8688-82d26c21f8a6 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415553,
            "message": "43 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415752,
            "message": "END RequestId: d0eee81f-b003-4cc9-8688-82d26c21f8a6\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415752,
            "message": "REPORT RequestId: d0eee81f-b003-4cc9-8688-82d26c21f8a6\tDuration: 214.87 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415780,
            "message": "START RequestId: 1e0e63ac-493f-4077-9c2e-6c30408514ba Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415787,
            "message": "42 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415972,
            "message": "END RequestId: 1e0e63ac-493f-4077-9c2e-6c30408514ba\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415972,
            "message": "REPORT RequestId: 1e0e63ac-493f-4077-9c2e-6c30408514ba\tDuration: 188.41 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877415996,
            "message": "START RequestId: 42d45695-a0b8-4509-a39a-81176cb892a4 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416001,
            "message": "41 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416192,
            "message": "END RequestId: 42d45695-a0b8-4509-a39a-81176cb892a4\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416192,
            "message": "REPORT RequestId: 42d45695-a0b8-4509-a39a-81176cb892a4\tDuration: 194.73 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416207,
            "message": "START RequestId: 504173f2-ab73-48c2-a8bc-df0a4d7921ad Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416214,
            "message": "40 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416432,
            "message": "END RequestId: 504173f2-ab73-48c2-a8bc-df0a4d7921ad\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416432,
            "message": "REPORT RequestId: 504173f2-ab73-48c2-a8bc-df0a4d7921ad\tDuration: 220.89 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416445,
            "message": "START RequestId: f161fa6e-01b2-4bd6-84d9-5127832f57a9 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416472,
            "message": "39 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416651,
            "message": "END RequestId: f161fa6e-01b2-4bd6-84d9-5127832f57a9\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416651,
            "message": "REPORT RequestId: f161fa6e-01b2-4bd6-84d9-5127832f57a9\tDuration: 203.42 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416672,
            "message": "START RequestId: d6ae0561-c344-4e28-895e-196cc66a9fa8 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416678,
            "message": "38 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416871,
            "message": "END RequestId: d6ae0561-c344-4e28-895e-196cc66a9fa8\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416871,
            "message": "REPORT RequestId: d6ae0561-c344-4e28-895e-196cc66a9fa8\tDuration: 196.66 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416874,
            "message": "START RequestId: 3aac867c-a4c2-4860-b94e-f18fc7aa64b4 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877416912,
            "message": "37 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877417091,
            "message": "END RequestId: 3aac867c-a4c2-4860-b94e-f18fc7aa64b4\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877417091,
            "message": "REPORT RequestId: 3aac867c-a4c2-4860-b94e-f18fc7aa64b4\tDuration: 215.15 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418471,
            "message": "START RequestId: 82cdb14b-ecdc-4c1f-a3f1-8fd100cd1446 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418476,
            "message": "30 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418711,
            "message": "END RequestId: 82cdb14b-ecdc-4c1f-a3f1-8fd100cd1446\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418711,
            "message": "REPORT RequestId: 82cdb14b-ecdc-4c1f-a3f1-8fd100cd1446\tDuration: 238.58 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418736,
            "message": "START RequestId: b2b7a640-fbc6-4503-86fc-5d5ff64240e9 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418743,
            "message": "29 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418932,
            "message": "END RequestId: b2b7a640-fbc6-4503-86fc-5d5ff64240e9\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418932,
            "message": "REPORT RequestId: b2b7a640-fbc6-4503-86fc-5d5ff64240e9\tDuration: 192.16 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418957,
            "message": "START RequestId: a7766810-5d1f-4ff5-b5c9-754010e8d505 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877418963,
            "message": "28 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419127,
            "message": "END RequestId: a7766810-5d1f-4ff5-b5c9-754010e8d505\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419127,
            "message": "REPORT RequestId: a7766810-5d1f-4ff5-b5c9-754010e8d505\tDuration: 167.32 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419182,
            "message": "START RequestId: f3fe47c3-1c40-404e-a949-1b2d53e6016c Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419189,
            "message": "27 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419432,
            "message": "END RequestId: f3fe47c3-1c40-404e-a949-1b2d53e6016c\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419432,
            "message": "REPORT RequestId: f3fe47c3-1c40-404e-a949-1b2d53e6016c\tDuration: 247.14 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419456,
            "message": "START RequestId: 14c41410-6ea4-4d18-bb2d-fd708f4afd3a Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419491,
            "message": "26 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419652,
            "message": "END RequestId: 14c41410-6ea4-4d18-bb2d-fd708f4afd3a\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419652,
            "message": "REPORT RequestId: 14c41410-6ea4-4d18-bb2d-fd708f4afd3a\tDuration: 192.51 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419675,
            "message": "START RequestId: ac72724e-5b50-485c-8e2e-7072bbb05d68 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419681,
            "message": "25 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419872,
            "message": "END RequestId: ac72724e-5b50-485c-8e2e-7072bbb05d68\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419872,
            "message": "REPORT RequestId: ac72724e-5b50-485c-8e2e-7072bbb05d68\tDuration: 193.78 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419901,
            "message": "START RequestId: 4df98e72-4547-4cf5-b881-4b1b9a402a50 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877419912,
            "message": "24 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420086,
            "message": "END RequestId: 4df98e72-4547-4cf5-b881-4b1b9a402a50\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420086,
            "message": "REPORT RequestId: 4df98e72-4547-4cf5-b881-4b1b9a402a50\tDuration: 181.69 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420116,
            "message": "START RequestId: eeb822cd-fbc4-4656-991c-801c854628ea Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420122,
            "message": "23 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420311,
            "message": "END RequestId: eeb822cd-fbc4-4656-991c-801c854628ea\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420311,
            "message": "REPORT RequestId: eeb822cd-fbc4-4656-991c-801c854628ea\tDuration: 192.93 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420338,
            "message": "START RequestId: 67bca645-77ef-409a-b985-12938fe3cecb Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420353,
            "message": "22 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420523,
            "message": "END RequestId: 67bca645-77ef-409a-b985-12938fe3cecb\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420523,
            "message": "REPORT RequestId: 67bca645-77ef-409a-b985-12938fe3cecb\tDuration: 182.02 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420556,
            "message": "START RequestId: 4dc8fbe3-6c82-4d33-97ad-ba5f963f7793 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420591,
            "message": "21 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420751,
            "message": "END RequestId: 4dc8fbe3-6c82-4d33-97ad-ba5f963f7793\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420751,
            "message": "REPORT RequestId: 4dc8fbe3-6c82-4d33-97ad-ba5f963f7793\tDuration: 192.14 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 72 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420769,
            "message": "START RequestId: d3a61edb-9827-4b29-a6a2-8c908a2611c9 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420776,
            "message": "20 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420971,
            "message": "END RequestId: d3a61edb-9827-4b29-a6a2-8c908a2611c9\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420971,
            "message": "REPORT RequestId: d3a61edb-9827-4b29-a6a2-8c908a2611c9\tDuration: 198.48 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877420997,
            "message": "START RequestId: 94ff987b-e26b-4ee7-8b06-7cbc7b8fbc47 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421032,
            "message": "19 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421191,
            "message": "END RequestId: 94ff987b-e26b-4ee7-8b06-7cbc7b8fbc47\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421191,
            "message": "REPORT RequestId: 94ff987b-e26b-4ee7-8b06-7cbc7b8fbc47\tDuration: 192.50 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421214,
            "message": "START RequestId: 4ce6b16e-e549-4eae-9cbe-98634e64152a Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421233,
            "message": "18 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421531,
            "message": "END RequestId: 4ce6b16e-e549-4eae-9cbe-98634e64152a\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421531,
            "message": "REPORT RequestId: 4ce6b16e-e549-4eae-9cbe-98634e64152a\tDuration: 314.75 ms\tBilled Duration: 400 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421550,
            "message": "START RequestId: dfa84b3e-d5c4-4d38-a13d-1de4f088fdc2 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421557,
            "message": "17 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421752,
            "message": "END RequestId: dfa84b3e-d5c4-4d38-a13d-1de4f088fdc2\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421752,
            "message": "REPORT RequestId: dfa84b3e-d5c4-4d38-a13d-1de4f088fdc2\tDuration: 198.04 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421753,
            "message": "START RequestId: e3cb8f1f-ad0f-4122-867d-98cdeed04b0c Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421792,
            "message": "16 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421951,
            "message": "END RequestId: e3cb8f1f-ad0f-4122-867d-98cdeed04b0c\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421951,
            "message": "REPORT RequestId: e3cb8f1f-ad0f-4122-867d-98cdeed04b0c\tDuration: 195.02 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877421969,
            "message": "START RequestId: 356daac7-6907-4c61-bc02-94e634757273 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422011,
            "message": "15 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422252,
            "message": "END RequestId: 356daac7-6907-4c61-bc02-94e634757273\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422252,
            "message": "REPORT RequestId: 356daac7-6907-4c61-bc02-94e634757273\tDuration: 280.86 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422264,
            "message": "START RequestId: d84a4987-0dcb-4cec-a622-fb81ae199a3c Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422274,
            "message": "14 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422512,
            "message": "END RequestId: d84a4987-0dcb-4cec-a622-fb81ae199a3c\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422512,
            "message": "REPORT RequestId: d84a4987-0dcb-4cec-a622-fb81ae199a3c\tDuration: 245.47 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422531,
            "message": "START RequestId: ee330b20-ea07-426e-94bd-efaca736c1c3 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422538,
            "message": "13 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422771,
            "message": "END RequestId: ee330b20-ea07-426e-94bd-efaca736c1c3\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422771,
            "message": "REPORT RequestId: ee330b20-ea07-426e-94bd-efaca736c1c3\tDuration: 237.32 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422784,
            "message": "START RequestId: 9f9cfa1c-5b0b-47a3-a4f0-a3ed42841a26 Version: $LATEST\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877422791,
            "message": "12 bottles of rootbeer.\n",
            "ingestionTime": 1590877422868
        },
        {
            "timestamp": 1590877423011,
            "message": "END RequestId: 9f9cfa1c-5b0b-47a3-a4f0-a3ed42841a26\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423011,
            "message": "REPORT RequestId: 9f9cfa1c-5b0b-47a3-a4f0-a3ed42841a26\tDuration: 223.98 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423039,
            "message": "START RequestId: bdb1e7be-037c-4391-a22c-7328729e0efc Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423046,
            "message": "11 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423211,
            "message": "END RequestId: bdb1e7be-037c-4391-a22c-7328729e0efc\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423211,
            "message": "REPORT RequestId: bdb1e7be-037c-4391-a22c-7328729e0efc\tDuration: 168.63 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423236,
            "message": "START RequestId: 390f7144-9919-4462-bf8b-6491ed24ca12 Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423271,
            "message": "10 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423433,
            "message": "END RequestId: 390f7144-9919-4462-bf8b-6491ed24ca12\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423433,
            "message": "REPORT RequestId: 390f7144-9919-4462-bf8b-6491ed24ca12\tDuration: 192.80 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423447,
            "message": "START RequestId: db2966fa-bec7-4e4b-aadc-737b09736bbd Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423454,
            "message": "9 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423652,
            "message": "END RequestId: db2966fa-bec7-4e4b-aadc-737b09736bbd\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423652,
            "message": "REPORT RequestId: db2966fa-bec7-4e4b-aadc-737b09736bbd\tDuration: 201.24 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423674,
            "message": "START RequestId: ce874b7e-908a-4c14-99c4-ed181d8d154b Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423682,
            "message": "8 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423891,
            "message": "END RequestId: ce874b7e-908a-4c14-99c4-ed181d8d154b\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423891,
            "message": "REPORT RequestId: ce874b7e-908a-4c14-99c4-ed181d8d154b\tDuration: 214.29 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423913,
            "message": "START RequestId: c2e0a77a-5326-4b4f-b715-0f7bf7a34d6c Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877423931,
            "message": "7 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424091,
            "message": "END RequestId: c2e0a77a-5326-4b4f-b715-0f7bf7a34d6c\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424091,
            "message": "REPORT RequestId: c2e0a77a-5326-4b4f-b715-0f7bf7a34d6c\tDuration: 175.87 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424115,
            "message": "START RequestId: c8cf1522-4b4c-44f5-a627-3342a112f2ec Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424121,
            "message": "6 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424312,
            "message": "END RequestId: c8cf1522-4b4c-44f5-a627-3342a112f2ec\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424312,
            "message": "REPORT RequestId: c8cf1522-4b4c-44f5-a627-3342a112f2ec\tDuration: 193.58 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424329,
            "message": "START RequestId: e424fa55-ec26-44b6-a956-99785fe6bcdc Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424373,
            "message": "5 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424531,
            "message": "END RequestId: e424fa55-ec26-44b6-a956-99785fe6bcdc\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424531,
            "message": "REPORT RequestId: e424fa55-ec26-44b6-a956-99785fe6bcdc\tDuration: 200.06 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424546,
            "message": "START RequestId: eb21158f-ff39-4dd8-b85e-6c7fed56d168 Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424572,
            "message": "4 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424751,
            "message": "END RequestId: eb21158f-ff39-4dd8-b85e-6c7fed56d168\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424751,
            "message": "REPORT RequestId: eb21158f-ff39-4dd8-b85e-6c7fed56d168\tDuration: 202.89 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424754,
            "message": "START RequestId: 1439616d-9443-4ee7-af8d-f1040a25a23e Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424790,
            "message": "3 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424972,
            "message": "END RequestId: 1439616d-9443-4ee7-af8d-f1040a25a23e\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424972,
            "message": "REPORT RequestId: 1439616d-9443-4ee7-af8d-f1040a25a23e\tDuration: 214.49 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424980,
            "message": "START RequestId: 743efd14-fb96-4b96-804a-01cd4fe9b588 Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877424994,
            "message": "2 bottles of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425171,
            "message": "END RequestId: 743efd14-fb96-4b96-804a-01cd4fe9b588\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425171,
            "message": "REPORT RequestId: 743efd14-fb96-4b96-804a-01cd4fe9b588\tDuration: 187.91 ms\tBilled Duration: 200 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425176,
            "message": "START RequestId: 29972f8c-c812-44da-b5f6-bdee35741217 Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425212,
            "message": "1 bottle of rootbeer.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425391,
            "message": "END RequestId: 29972f8c-c812-44da-b5f6-bdee35741217\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425391,
            "message": "REPORT RequestId: 29972f8c-c812-44da-b5f6-bdee35741217\tDuration: 210.85 ms\tBilled Duration: 300 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425413,
            "message": "START RequestId: 18ca23b9-80a7-42c3-8fcc-ab972c89f0d5 Version: $LATEST\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425432,
            "message": "All gone.\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425451,
            "message": "END RequestId: 18ca23b9-80a7-42c3-8fcc-ab972c89f0d5\n",
            "ingestionTime": 1590877432028
        },
        {
            "timestamp": 1590877425451,
            "message": "REPORT RequestId: 18ca23b9-80a7-42c3-8fcc-ab972c89f0d5\tDuration: 34.85 ms\tBilled Duration: 100 ms\tMemory Size: 128 MB\tMax Memory Used: 73 MB\t\n",
            "ingestionTime": 1590877432028
        }
    ],
    "nextForwardToken": "f/35477752107077147613512317871369777758041220575285608497",
    "nextBackwardToken": "b/35477751848343901820160028172198653813274267019968905216"
}
root@196c6175b6bc:/repos/aws-auto#
```
