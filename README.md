# ng-classifyfy
an ng-classify browerify transform with coffeescript error handing, written in coffeescript.

# Usage
```coffee
ngclassifyfy = require('ngclassifyfy')

ngClassifyOptions =
    appName: 'catmanApp'

b = browserify()
b.transform(ngclassifyfy(ngClassifyOptions))
```
## error handling

coffeeescript error reporting is already baked into the transform, but you can modify it:

```coffee
ngclassifyfy = require('ngclassifyfy')
ngclassifyfy.errorHandler = (file, err) ->
    console.log('this handler is not as good as the one that comes with this transform!', err)
 ```

# install
```bash
npm install ngclassifyfy --save-dev
```