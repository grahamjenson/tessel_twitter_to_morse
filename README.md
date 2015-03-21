# Getting Started

```
npm install -g tessel
```

Connect tessel to wifi:

```
tessel wifi -n [network name] -p [password] -s [security type*]
```

Run with:

```
coffee -c twitter_morse_code.coffee
tessel run twitter_morse_code.js
```

# Dependencies 

[morsecode](https://www.npmjs.com/package/morsecode)
[q](https://www.npmjs.com/package/q) ([bluebird](](https://www.npmjs.com/package/bluebird) doesn't work)

[node-twitter](https://www.npmjs.com/package/node-twitter) ( [twitter](https://www.npmjs.com/package/twitter) doesn't work)

## Changes

The code:

```
console.log(typeof undefined)
console.log(typeof null)
```

in node 0.12 returns

```
undefined
object
```

but on the tessel it returns:

```
undefined
undefined
```

This means that lines like this:

```
if (typeof uri === 'undefined') throw new Error('undefined is not a valid uri or options object.')
```

from the [request](https://www.npmjs.com/package/request) package dependency of node-twitter will break. Delete that line and it will work :)