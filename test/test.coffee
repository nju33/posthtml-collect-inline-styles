fs           = require 'fs'
path         = require 'path'
CSON         = require 'cson'
chai         = require 'chai'
expect       = chai.expect
posthtml     = require 'posthtml'

collectInlineStyles = require '..'

describe 'posthtml-collect-inline-styles', ->
  it 'has class', ->
    before = fs.readFileSync './test/cases/has-class/before.html', 'utf-8'
    after = fs.readFileSync './test/cases/has-class/after.html', 'utf-8'

    posthtml()
      .use collectInlineStyles
      .process before
      .then (result) ->
        expect(result.html).to.equal(after)
