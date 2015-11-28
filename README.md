# posthtml-collect-inline-styles

[![npm version](https://badge.fury.io/js/posthtml-collect-inline-styles.svg)](https://badge.fury.io/js/posthtml-collect-inline-styles)

[PostHTML](https://github.com/posthtml/posthtml) plugin that collect inline styles and insert to `<head>`

## Install

```
npm i posthtml-collect-inline-styles

# if still
npm i posthtml
```

## Usage

Create .html file. (e.g. index.html)
```html
<!DOCTYPE html>
<html>
<head>
  <title>Example</title>
</head>
<body style="margin: 0;">

  <ul>
    <li class="block__item" style="margin-top: .5em;"></li>
    <li class="block__item"></li>
    <li class="block__item"></li>
  </ul>

  <div>
    <div class="first__class">
      <div class="second__class">
        <div class="third__class">
          <p>
            <span style="color: orange;"></span>
          </p>
          <p style="margin-top: 5px;"></p>
        </div>
      </div>
      <hr style="border-top: 1px solid orange;">
    </div>
  </div>

</body>
</html>

```

Transform it, Use the this plugin and **PostHTML** (e.g. posthtml.js)
```javascript
const fs                   = require('fs'),
      posthtml             = require('posthtml'),
      collectInlineStyles  = require('posthtml-collect-inline-styles');

const beforeHtml = fs.readFileSync('./index.html', 'utf-8'),
      afterHtml  = posthtml()
                     .use(collectInlineStyles)
                     .process(beforeHtml, {sync: true})
                     .html;

console.log(afterHtml);

```

`output` will be
```html
<!DOCTYPE html>
<html>
<head>
  <title>Example</title>
<style>
body {
  margin: 0;
}
.block__item {
  margin-top: .5em;
}
.third__class span {
  color: orange;
}
.third__class > p {
  margin-top: 5px;
}
.first__class > hr {
  border-top: 1px solid orange;
}
</style>
</head>
<body>

  <ul>
    <li class="block__item"></li>
    <li class="block__item"></li>
    <li class="block__item"></li>
  </ul>

  <div>
    <div class="first__class">
      <div class="second__class">
        <div class="third__class">
          <p>
            <span></span>
          </p>
          <p></p>
        </div>
      </div>
      <hr>
    </div>
  </div>

</body>
</html>

```

## Run example

**1** Close this repository

```
git clone git@github.com:totora0155/posthtml-collect-inline-styles.git
```

**2** Change current directory
```
cd posthtml-collect-inline-styles
```

**3** Install modules
```
npm install
```

**4** Run script
```
npm run example
```
