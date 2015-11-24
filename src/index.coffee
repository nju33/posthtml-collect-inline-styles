collectWalker = do ->
  css = []
  (root) ->
    return if not root.tag?

    if root.attrs?.style?
      attr =
        class: '.' + root.attrs.class
        style: root.attrs.style

      css.push attr
      root.attrs.style = false

    if root.content?
      for node in root.content
        collectWalker node

    css

collectInlineStyles = (tree) ->
  attrs = null

  tree
    .match {tag: 'body'}, (node) ->
      attrs = collectWalker node
      node
    .match {tag: 'head'}, (node) ->
      tag = 'style'
      content = ["\n"]
      for attr in attrs
        dcrl = [
          attr.class + " {\n"
          '  ' + attr.style + "\n"
          "}\n"
        ]
        content = content.concat dcrl

      node.content.push {tag, content}
      node.content.push "\n"
      node

module.exports = collectInlineStyles
