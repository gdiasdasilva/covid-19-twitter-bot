# 🤖 COVID-19 Twitter Bot

This repository was created as a playground to get to know the Twitter API and the twitter gem.
The result was a simple bot that tweets the most recent data (in this [profile](https://twitter.com/COVID19PTBot)) about COVID-19 in Portugal.

Tweets have the following format:

```
🦠 Actualização // 19-05-2020 🦠

😷 Casos confirmados: 29432 (+223 que no dia anterior)
💪 Casos recuperados: 6431
🏥 Internados em UCI: 101
⚰️ Óbitos: 1247

#COVID19PT #COVID
```

All data comes from [VOST Portugal's REST API](https://covid19-api.vost.pt). Props to them. 👏

## Running the app

```
$ ruby app/main.rb
```
