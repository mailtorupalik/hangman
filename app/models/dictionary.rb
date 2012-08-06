class Dictionary < ActiveRecord::Base
    validates :word, :presence => true, :uniqueness => true, :on => :create
end
