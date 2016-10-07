RubyWrap = require '../lib/ruby-wrap'

describe "RubyWrap", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('ruby-wrap')
    editor: null

  describe "when the ruby-wrap:wrap-line event is triggered", ->
    it "wraps the line", ->
      atom.commands.dispatch workspaceElement, 'ruby-wrap:wrap-line'

      waitsForPromise ->
        atom.workspace.open('fixture.rb').then (o) ->
          editor = o
      waitsForPromise ->
        activationPromise

      runs ->
        # https://atom.io/docs/api/v1.10.2/TextEditor
        expect(editor.getText()).toEq("subject\n{stuff\n}")
        #
        # rubyWrapElement = workspaceElement.querySelector('.ruby-wrap')
        # expect(rubyWrapElement).toExist()
        #
        # rubyWrapPanel = atom.workspace.panelForItem(rubyWrapElement)
        # expect(rubyWrapPanel.isVisible()).toBe true
        # atom.commands.dispatch workspaceElement, 'ruby-wrap:toggle'
        # expect(rubyWrapPanel.isVisible()).toBe false
