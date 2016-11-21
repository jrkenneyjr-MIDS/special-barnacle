import tweepy

consumer_key = "a4eUiWdNPOVuRnWPYa6MqTMIr";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "QOzqnRG0qnfSfaz7ZuihrC4xchvlI0B8myGzAeZYPQ9Axc3z4w";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "141512425-IAUyVfnU2I0413EUU9FIrcah3XzBC1oKl59v4IjL";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "Vw1Ucp8gTolpfDndqazoY3CCsvNfnCwF7Yu5H3iOCoPql";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



