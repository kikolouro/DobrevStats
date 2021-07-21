import yaml
from yaml.loader import SafeLoader
import json
import tweepy
import datetime 
with open('../config.yml') as f:
    data = yaml.load(f, Loader=SafeLoader)

listener = data[0]

def startStream(stream):
    while True:
        try:
            print("BOT INICIALIZADO")
            stream.filter(follow=['2928280618'], stall_warnings=True)
        except:
            print("A REINICIAR")
            continue

class MyStreamListener(tweepy.StreamListener):
    def __init__(self, api):
        self.api = api
        self.me = api.me()

    def on_status(self, tweet):
            print(tweet.text)
            my_date = datetime.date.today() 
            _, week_num, _ = my_date.isocalendar()
            file = f"Semana{week_num}.txt"
            with open(f"/ext/{file}", "a") as File:
                File.write(f"{tweet.text}\n")
    def on_error(self, status_code):
        print(f"ERROR {status_code}")


auth = tweepy.OAuthHandler(listener['apikey'], listener["apisecretkey"])
auth.set_access_token(listener["acesstoken"], listener["acesstokensecret"])

# Create API object
api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)

tweets_listener = MyStreamListener(api)
stream = tweepy.Stream(api.auth, tweets_listener)
startStream(stream)
