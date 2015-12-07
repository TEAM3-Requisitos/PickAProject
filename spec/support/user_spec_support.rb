module UserHelper
	def create_user(options = {})
		user = User.create({
				username: "userexample",
				name: "name example",
				email: "example@email.com",
				password: "password",
				password_confirmation: "password"
			}.merge(options))
		return user
	end

	def create_skill(options = {})
		skill = Skill.create({
				name: "skill example"
			}.merge(options))
		return skill
	end
end
