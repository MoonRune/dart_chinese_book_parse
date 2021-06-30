A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

##RoadMap
### dart support test
1. ~~test Json pattern~~
2. ~~test Js pattern~~ use dll in cli app
3. ~~test jsoup pattern~~
3. ~~test xpath pattern~~ unsupported
3. ~~test regex pattern~~ some incompatible
## code gen
1. ~~software flow~~
    1. prase bookSourceOld
    1. parse bookSource
    1. vlidateBookSources
    1. task [search,catalogue,detail]
        2. get${task}params
        2. build${task}url
        2. bookSource.${task}
        2. switch${task}Agent
        2. get${task}Result
        2. parse${task}Result
        2. switch${task}ResultConverter
        2. build${task}Result
        2. validate${task}Result
        2. return${task}Result(s)

1. ~~software structure~~
    1. BookSource
    2. AgentFactory,Agent
    2. DataFactory,String
    2. DataValidator
    2. Book
1.  support fun
1.  mock data
2.  real data
## ui
1. flutter


Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
