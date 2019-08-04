---
title: "nodejs/typescriptでSNSイベントからgetMetricWidgetImage(画像)を取得する"
date: 2019-08-04T13:25:09+09:00
draft: false
---

こんな感じのコードでできた

- `MetricWidget` の型定義はaws-sdkにはなかった
  - ドキュメントにはなっていた
  - [GetMetricWidgetImage: Metric Widget Structure and Syntax - Amazon CloudWatch](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/APIReference/CloudWatch-Metric-Widget-Structure.html)
- `SNSEvent` の型定義は↓
  - [DefinitelyTyped/index.d.ts at master · DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/aws-lambda/index.d.ts#L206)

```ts
import { SNSEvent } from 'aws-lambda';
import { CloudWatch } from 'aws-sdk';
import { isBuffer } from 'util';

type MetricWidget = {
  width: number;
  height: number;
  start: string;
  end: string;
  timezone: '+0900';
  view: 'timeSeries';
  stacked: boolean;
  stat: 'SampleCount' | 'Average' | 'Sum' | 'Minimum' | 'Maximum' | 'p99';
  title: string;
  // [Namespace, MetricName, Dimension1Name, Dimension1Value, Dimension2Name, Dimension2Value... {Options Object}]
  metrics: string[][];
  period: 300;
};

export const getMetricWidgetImageWithSNSEvent = async (
  event: SNSEvent,
  options = {}
) => {
  const cloudWatch = new CloudWatch({ region: 'ap-northeast-1' });
  const snsMessage = JSON.parse(event.Records[0].Sns.Message);
  const { Namespace, MetricName } = snsMessage.Trigger;
  const MetricWidget = JSON.stringify({
    title: `${Namespace}: ${MetricName}`,
    width: 1200,
    height: 500,
    metrics: [[Namespace, MetricName]],
    start: '-PT3H',
    end: 'PT0H',
    timezone: '+0900',
    view: 'timeSeries',
    period: 300,
    stacked: false,
    stat: 'Sum',
    ...options
  } as MetricWidget);
  const response = await cloudWatch
    .getMetricWidgetImage({ MetricWidget })
    .promise();
  if (isBuffer(response.MetricWidgetImage)) {
    return response.MetricWidgetImage;
  } else {
    throw Error(JSON.stringify({ response, event, options }));
  }
};
```

metricsの型がperlみたいで(酷くて)ちょっと面白かった

> [Namespace, MetricName, Dimension1Name, Dimension1Value, Dimension2Name, Dimension2Value... {Options Object}]
