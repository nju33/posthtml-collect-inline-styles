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

    html = posthtml()
             .use collectInlineStyles
             .process before, {sync: true}
             .html
    expect(html).to.equal(after)

  it 'doesnt have class',  ->
    before = fs.readFileSync './test/cases/doesnt-have-class/before.html', 'utf-8'
    after = fs.readFileSync './test/cases/doesnt-have-class/after.html', 'utf-8'

    html = posthtml()
             .use collectInlineStyles
             .process before, {sync: true}
             .html
    expect(html).to.equal(after)

  it 'parent has class',  ->
    before = fs.readFileSync './test/cases/parent-has-class/before.html', 'utf-8'
    after = fs.readFileSync './test/cases/parent-has-class/after.html', 'utf-8'

    html = posthtml()
             .use collectInlineStyles
             .process before, {sync: true}
             .html
    expect(html).to.equal(after)
