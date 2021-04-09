---
title: Moment.js-输出明天、今天和昨天
date: 2019-09-08 15:23:25
tags: [moment] 
---



```js
let today     = moment(new Date());

let tomorrow  = moment(new Date()).add(1,'days');

let yesterday = moment(new Date()).add(-1, 'days');
```





```js
import moment from '@src/plugins/moment';

function rangeDays(start, end, current) {
  return current && (moment().subtract(start, 'days').valueOf() > current.valueOf() || moment().add(end, 'days').valueOf() < current.valueOf());
}

// 今天之前不可用
export const beforeToday = current => current && moment().subtract(1, 'days').valueOf() > current.valueOf();

// 今天之前可用
export const afterToday = current => current && moment().subtract(1, 'days').valueOf() < current.valueOf();

// 明天之前不可用
export const beforeTomorrow = current => current && current.valueOf() < Date.now();

// 今天至6天后可用
export const fromTodayTo6Days = current => rangeDays(1, 6, current);

// 今天至30天后可用
export const fromTodayTo30Days = current => rangeDays(1, 30, current);

// 今天以后的一年可用
export const fromTodayTo1Year = current => rangeDays(1, 365, current);

// 今天以后的两年可用
export const fromTodayTo2Years = current => rangeDays(1, 730, current);

// 明天至30天后可用
export const fromTomorrowTo30Days = current => rangeDays(0, 30, current);

// 禁用时间区域 从指定日期到昨天
(current && current.valueOf() < moment(this.startDate)).valueOf() || current.valueOf() > moment().subtract(1, 'days').valueOf()
```