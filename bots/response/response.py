import tweepy
import datetime
import yaml
from yaml.loader import SafeLoader

with open('/app/bots/config.yml') as f:
    data = yaml.load(f, Loader=SafeLoader)

response = data[1]

def largest(arr):
    max = arr[0]
    largesti = 0
    for i in range(len(arr)):    
        if(arr[i] > max):    
            max = arr[i]
            largesti = i
    if max == 1:
        return None
    else:
        return largesti

auth = tweepy.OAuthHandler(response['apikey'], response["apisecretkey"])
auth.set_access_token(response["acesstoken"], response["acesstokensecret"])

api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)


my_date = datetime.date.today() 
year, week_num, day = my_date.isocalendar()

if week_num == 1:
    week_num = 52
file = f"Semana{week_num -1 }.txt"

with open(f"/ext/{file}", "r") as File:
    rtcount = 0
    tweets = []
    for line in File.readlines():
        if "RT @TheDobrev10:" in line:
            rtcount += 1
        else:
            tweets.append(line)

with open("/ext/tweets.txt", "a") as File:
    File.writelines(tweets)

with open("/ext/tweets.txt", "r") as File:
    tweets = File.readlines()
    tweets = [x.strip() for x in tweets] 


repetidos = []
for line in tweets:
    repetidos.append(tweets.count(line))


try:
    print(f"o tweet mais repetido é {tweets[largest(repetidos)]}")
    api.update_status(f"O Dobrev na semana {week_num} do ano {year} deu {rtcount} Retweets nos seus próprios tweets!!\nTweet que o grande Dobrev repete mais é: {tweets[largest(repetidos)]}")
except (IndexError, TypeError) as e:
    print(f"O Dobrev na semana {week_num} do ano {year} deu {rtcount} Retweets nos seus próprios tweets!!\n Ainda sem dados quanto a tweets :(")
    api.update_status(f"O Dobrev na semana {week_num} do ano {year} deu {rtcount} Retweets nos seus próprios tweets!!\nAinda sem dados de tweets, dêm-lhe algun tempo :(")
