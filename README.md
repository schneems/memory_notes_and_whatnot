## Script

```
cd ~/Documents/projects/rails
```

For `respond_to`
- Before: 134dab46e4e94d7e6e37cec43dca8183fe72aea6
- Actual: f45267bc423017109e442e5c35a5765dc482b12b


## In Codetriage

In another tab

```
chruby 2.5
cd ~/Documents/projects/codetriage
git co schneems/6.ohhh
bundle install
```

Get the output:

```
bundle exec derailed exec perf:objects
```

then

```
ALLOW_FILES=active_record/attribute_methods.rb bundle exec derailed exec perf:objects
```

