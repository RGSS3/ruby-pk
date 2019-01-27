$: << './lib'
require 'ruby-pk'
context :a do
    import({
        :numpy => :np,
    })
end

context :b do
    use :a
    run %{
        print(np.array([1,2,3,4,5]))
        if 3 > 5:
            print(3)
        else:
            print(5)
    }
end

context :c do
    use :a
    run %{
        print('Hello world')
    }
end
run :b
run :c