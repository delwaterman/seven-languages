#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#---
class Tree
  attr_accessor :children, :node_name
  
  def initialize(tree_hash)
    raise "Should only have one key" unless tree_hash.length == 1
    @node_name = tree_hash.keys.first
    val_hash = tree_hash.values.first
    @children = val_hash.to_a.collect do |node_name, children|
      Tree.new(node_name => children)
    end
    
  end
  
  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end
  
  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new( 'grandpa' => { 'dad' => {'child_1' => {}, 'child_2' => {}}, 'uncle' => {'child_3' => {}, 'child_4' => {}}})

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}
