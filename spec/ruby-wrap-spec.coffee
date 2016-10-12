RubyWrap = require '../lib/ruby-wrap'

describe "RubyWrap", ->
  [workspaceElement, activationPromise, editor] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('ruby-wrap')

    waitsForPromise ->
      atom.workspace.open().then (o) ->
        editor = o

    waitsForPromise ->
      atom.packages.activatePackage('language-ruby')


  describe "when the ruby-wrap:wrap-line event is triggered", ->
    it "wraps the line", ->
      editor.insertText("        let(:something) { create(User, property_a: 'foo', propert_b: { hash: 123}, property_c: 'bar')}")

      atom.commands.dispatch workspaceElement, 'ruby-wrap:wrap-line'

      waitsForPromise -> activationPromise

      expect(editor.getText()).toContain("let(:something) do
        create(
          User,
          property_a: 'foo',
          propert_b: { hash: 123 },
          property_c: 'baz'
        )
      end")
