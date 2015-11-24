// Generated by CoffeeScript 1.10.0
(function() {
  var collectInlineStyles, collectWalker;

  collectWalker = (function() {
    var css;
    css = [];
    return function(root) {
      var attr, i, len, node, ref, ref1;
      if (root.tag == null) {
        return;
      }
      if (((ref = root.attrs) != null ? ref.style : void 0) != null) {
        attr = {
          "class": '.' + root.attrs["class"],
          style: root.attrs.style
        };
        css.push(attr);
        root.attrs.style = false;
      }
      if (root.content != null) {
        ref1 = root.content;
        for (i = 0, len = ref1.length; i < len; i++) {
          node = ref1[i];
          collectWalker(node);
        }
      }
      return css;
    };
  })();

  collectInlineStyles = function(tree) {
    var attrs;
    attrs = null;
    return tree.match({
      tag: 'body'
    }, function(node) {
      attrs = collectWalker(node);
      return node;
    }).match({
      tag: 'head'
    }, function(node) {
      var attr, content, dcrl, i, len, tag;
      tag = 'style';
      content = ["\n"];
      for (i = 0, len = attrs.length; i < len; i++) {
        attr = attrs[i];
        dcrl = [attr["class"] + " {\n", '  ' + attr.style + "\n", "}\n"];
        content = content.concat(dcrl);
      }
      node.content.push({
        tag: tag,
        content: content
      });
      node.content.push("\n");
      return node;
    });
  };

  module.exports = collectInlineStyles;

}).call(this);