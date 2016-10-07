{CompositeDisposable} = require 'atom'

module.exports = RubyWrap =
  subscriptions: null


  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'ruby-wrap:wrap-line': => @wrapLine()

  deactivate: ->
    @subscriptions.dispose()

  wrapLine: ->
    if editor = atom.workspace.getActiveTextEditor()
      editor.moveToEndOfLine()
      editor.selectToFirstCharacterOfLine()

      line = editor.getSelectedText()
      newline = line.replace(/([{}[\]()])/ig, "$1\n")

      editor.insertText(newline, { autoIndent: true } )
