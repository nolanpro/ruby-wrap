class Foo
  def bar
    let(:something) do
      create(
        User,
        property_a: 'foo',
        propert_b: { hash: 123 },
        property_c: 'baz'
      )
    end
