# imports

tessel = require('tessel')
keys = require './twitter_keys.json'
MorseCode = require("morsecode");
morseConverter = new MorseCode();
Twitter = require('node-twitter');
q = require('q')


# dot-dash LED promises
led1 = tessel.led[0]
led2 = tessel.led[1]

toggle = (led, time) ->
  led.write(true)
  q.delay(time)
  .then( -> 
    led.write(false)
  )

dot = ->
  console.log 'dot'
  toggle(led1, 100)

dash = ->
  console.log 'dash'
  toggle(led2, 200)


morse_blink = (message, text) ->
  console.log "BLINKING", text
  promise = q.fcall( -> )
  for char in message
    console.log 
    if char == '.'
      promise = promise.then( -> dot())
    else if char == '_'
      promise = promise.then( -> dash())

  promise

#twitter stream

twitterStreamClient = new Twitter.StreamClient(keys.key, keys.secret, keys.akey, keys.asecret);

promise = q.fcall( -> )
twitterStreamClient.on('tweet', (tweet) ->
  text = tweet.text
  morse = morseConverter.translate(tweet.text)
  console.log text
  console.log morse
  promise = promise.then( -> morse_blink(morse, text))
);

twitterStreamClient.start(['grahamjenson']);