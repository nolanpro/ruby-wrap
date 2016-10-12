{CompositeDisposable} = require 'atom'

module.exports = RubyWrap =
  subscriptions: null
  current_indent_spaces: 0
  indent_spaces: 2
  converted: []

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'ruby-wrap:wrap-line': => @wrapLine()

  deactivate: ->
    @subscriptions.dispose()

  wrapLine: ->
    if editor = atom.workspace.getActiveTextEditor()
      editor.moveToEndOfLine()
      editor.selectToBeginningOfLine()

      line = editor.getSelectedText()
      # try
      @convert(line)
      # catch e
      #   converted = line
      console.log @converted
      console.log @converted.join("\n")
      editor.insertText(@converted.join("\n"), { autoIndent: true } )

  convert: (line) ->
    @current_indent_spaces = line.match(/^\s*/)[0].length
    @converted = [line.replace(/^\s*/, '')]
    next_element = @doEndConvert(@converted[0])
    next_element = @parenthesisConvert(next_element)


    # @betwixCurlies(line)
    # wrapped

  # betwixCurlies: (str) ->
  #   str.match(/\{.*\}/g)[0]

  parenthesisConvert: (element) ->
    # original_indent = @indent()
    # new_indent = @indent(1)
    if element[0].match(/\((.*)\)/)
      val = element[0].replace(/\((.*)\)/, "(\n$1\n)")
      vals = val.split("\n")
      vals[1] = [vals[1]]
      element = vals
      debugger
      return element[1]
    else
      return element[0]

  doEndConvert: (str) ->
    if str.match(/\)\s*\{/)
      # original_indent = @indent()
      # new_indent = @indent(1)
      val = str.replace(/\)\s*\{(.*)\}/, ") do\n$1\nEND")
      vals = val.split("\n")
      vals[1] = [vals[1]]
      @converted = vals
      return @converted[1]
    else
      return @converted[0]


  # indent: (amount = 0) ->
  #   if amount < 0
  #     @current_indent_spaces =
  #       @current_indent_spaces - (@indent_spaces * (amount * -1))
  #   else if amount >= 1
  #     @current_indent_spaces =
  #       @current_indent_spaces + (@indent_spaces * amount)
  #   @spaces(@current_indent_spaces)
  #
  spaces: (num) ->
    ' '.repeat(num)
