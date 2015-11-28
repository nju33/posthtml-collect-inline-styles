getClass = (className) ->
  '.' + className.split(/\s/)[0]

getSelector = (tagname, closest) ->
  if closest? and closest.count > 0
    closest.class + ' ' + tagname
  else if closest? and closest.count is 0
    closest.class + ' > ' + tagname
  else
    tagname

collectWalker = do ->
  attrs = []
  closest = null
  (root, closest) ->
    return if not root.tag?

    if root.attrs?.style?
      attr =
        class: do ->
          if root.attrs.class
            getClass root.attrs.class
          else
            getSelector root.tag, closest
        style: root.attrs.style

      attrs.push attr
      root.attrs.style = false

    if root.attrs?.class?
      closest =
        class: getClass root.attrs.class
        count: 0
    else if closest?
      closest.count++

    if root.content?
      for node in root.content
        collectWalker node, closest

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
