const fs                   = require('fs'),
      path                 = require('path'),
      posthtml             = require('posthtml'),
      collectInlineStyles  = require('..');

const beforeHtml = fs.readFileSync('example/index.html', 'utf-8'),
      afterHtml  = posthtml()
                   .use(collectInlineStyles)
                   .process(beforeHtml, {sync: true})
                   .html;

console.log(afterHtml);
