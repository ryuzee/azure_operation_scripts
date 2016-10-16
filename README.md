# Azure / Example for Retrieving Charge Data

This sample program retrieves your Azure usage and rate via API, merges them and calculate the ammount of charge.

## Preparation

You need to prepare those variables below.

- AppId
- OfferDurableId
- SubscriptionId
- TenantId
- client secret

## Command example

```
ruby main.rb \
  -a b6b07347-3720-4166-8718-3669ba816c04 \
  -c your_password \
  -d MS-AZR-0003P \
  -t 79ed722a-68ax-4229-82ja-55d0646c288e \
  -s 56a58e9b-a41d-3464-9f85-5a8b037f650b \
  -r this_month
```

## Technical Information

### Usage API response data (excerption)

```
{
  "id":"/subscriptions/56a58e9b-a41d-3464-9f85-5a8b037f650b/providers/Microsoft.Commerce/UsageAggregates/Daily_BRSDT_20161001_0000"
  "name":"Daily_BRSDT_20161001_0000"
  "type":"Microsoft.Commerce/UsageAggregate"
  "properties":{
    "subscriptionId":"56a58e9b-a41d-3464-9f85-5a8b037f650b"
    "usageStartTime":"2016-09-23T00:00:00+00:00"
    "usageEndTime":"2016-09-24T00:00:00+00:00"
    "meterName":"DNS Queries (1M)"
    "meterCategory":"Networking"
    "meterSubCategory":"Traffic Manager"
    "unit":"1M Queries"
    "instanceData":"{
      \"Microsoft.Resources\":{\"resourceUri\":\"/subscriptions/56a58e9b-a41d-3464-9f85-5a8b037f650b/resourceGroups/oss/providers/Microsoft.Network/trafficManagerProfiles/slidehub\",\"location\":\"global\"}}"
    "meterId":"c7a0c9f2-b08a-4f54-955f-c2ba8c7b0837"
    "infoFields":{}
    "quantity":0.000103
  }
}
```

### RateCard API response data (excerption)

```
"Meters":{
  {
    "MeterId":"d83fa551-8030-416a-b443-306aef06a5d2"
    "MeterName":"コンピューティング時間"
    "MeterCategory":"Virtual Machines"
    "MeterSubCategory":"Standard_D14 VM (Windows)"
    "Unit":"時間"
    "MeterTags":[]
    "MeterRegion":"米国東部"
    "MeterRates":{"0":157.28400000000002}
    "EffectiveDate":"2015-10-01T00:00:00Z"
    "IncludedQuantity":0.0
  }
}
```
