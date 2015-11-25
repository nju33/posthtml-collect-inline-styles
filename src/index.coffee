collectWalker = do ->
  attrs = []
  (root) ->
    return if not root.tag?

    if root.attrs?.style?
      attr =
        class: do ->
          if root.attrs.class
            '.' + root.attrs.class
          else
            root.tag
        style: root.attrs.style

      attrs.push attr
      root.attrs.style = false

    if root.content?
      for node in root.content
        collectWalker node

    attrs

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
        dcrls = do ->
          dcrls = attr.style.split(/;/)
            .filter (dcrl) -> not /^[\n\s]*$/.test dcrl
            .map (dcrl) ->
              replaced = dcrl.replace /^[\n\s]*|[\n\s]*$/, ''
              '  ' + replaced + ";\n"
          dcrls
        css = do ->
          selector = [
            attr.class + " {\n"
            "}\n"
          ]
          Array::splice.apply selector, [1, 0].concat dcrls
          selector

        content = content.concat css

      node.content.push {tag, content}
      node.content.push "\n"
      node

module.exports = collectInlineStyles
