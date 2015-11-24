fs           = require 'fs'
path         = require 'path'
CSON         = require 'cson'
chai         = require 'chai'
expect       = chai.expect
posthtml     = require 'posthtml'

collectInlineStyles = require '..'

describe 'posthtml-collect-inline-styles', ->
  it 'expect', ->
    before = fs.readFileSync './test/cases/test/before.html', 'utf-8'
    after = fs.readFileSync './test/cases/test/after.html', 'utf-8'

    posthtml()
      .use collectInlineStyles
      .process before
      .then (result) ->
        expect(result.html).to.equal(after)
