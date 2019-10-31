class Tweet < ApplicationRecord
	belongs_to :user
    
	has_many :tweet_tags
    has_many :tags, through: :tweet_tags
    
    validates :message, presence: true
    validates :message, length: {maximum: 140, too_long: "A tweet is only 140 max. Everybody knows that!"}, on: :create

    #RUN link_check FUNCTION BEFORE VALIDATION ABOVE 
	before_validation :link_check, on: :create
	#RUN apply_link FUNCTION AFTER VALIDATION ABOVE
	after_validation :apply_link, on: :create

    def link_check
		arr = self.message.split()
		index = arr.map{|x| x.include?('http://') || x.include?('https://')}.index(true)

		if index != nil
			self.link = arr[index]
			if arr[index].length > 23
				arr[index] = "#{arr[index][0..20]}..."
				self.message = arr.join(' ')
			end
		end
	end

	def apply_link
		arr = self.message.split
		index = arr.map{|x| x.include?('http://') || x.include?('https://')}.index(true)		

		if index != nil
			url = arr[index]
			arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
			self.message = arr.join(' ')
		end
	end
end
