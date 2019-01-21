markov chains in ~20 lines of sh, grep, cut and awk

the models can be incrementally trained by appending new data to them through
the ```mrkfeed.awk``` script (4 lines of awk)

```mrkwords.sh``` can generate word chains from a model using only
sh, grep, awk and shuf. an initial ```grep -Fw``` pass is done to quickly narrow
down huge model files. then awk (much slower than grep) does a second pass which
matches the pairs that actually begin with the word

in the interest of simplicity, the model is stored a flat plaintext file with word
pairs. this is inefficient but much simpler than using a directory tree or more
advanced structures. it also makes it easy to parse the model yourself with simple
tools like awk and grep

no extra care is taken in stripping separators that awk doesn't automatically handle
like symbols, commas and such

# usage
feed new data to an existing model or create it if it doesn't exist:

```sh
./mrkfeed.awk < input.txt >> model.mrkdb
```

generate a chain up to 50 words long from a model

```sh
./mrkwords.sh model.mrkdb 50
```

generate a sentence up to 50 words long

```sh
./mrkwords.sh model.mrkdb 50 | tr '\n' ' ' && echo
```

generate a sentence up to 50 words long that starts with "hello"

```sh
./mrkwords.sh model.mrkdb 50 hello | tr '\n' ' ' && echo
```
