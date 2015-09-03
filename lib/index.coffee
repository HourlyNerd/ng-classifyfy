through = require('through')
gutil = require('gulp-util')
ngClassify = require('ng-classify')
colors = require("colors")

handleError = (file, err) ->
    error = new gutil.PluginError('ngclassifyfy', err)
    loc = error.location
    issue = error.code.split("\n")[loc.first_line]
    before = issue[loc.first_line - 1] or ""
    after = issue[loc.first_line + 1] or ""
    before = before + "\n" if before
    after = "\n" + after if after
    first = issue.substring(0, loc.first_column)
    middle = issue.substring(loc.first_column, loc.last_column)
    last = issue.substring( loc.last_column)
    console.log("coffeescript! #{error.name}:".red.bold.underline
        "'#{error.message}' in #{file}"+"@".bold+"#{loc.first_line}:#{loc.first_column}\n"
        before+first+middle.red.underline+last+after
    )
createTransform = (ngClassifyOptions = {}) ->
    return  (file) ->
        return through() if not (/\.coffee$/i).test(file)
        data = ""
        return through((buf) ->
            data += buf
        , ->
            try
                data = ngClassify(data, ngClassifyOptions)
                this.queue(data)
                this.queue(null)
            catch err
                module.exports.handleError(file, err)
        )

module.exports = createTransform
module.exports.handleError = handleError
module.exports.ngclassifyfy = createTransform
