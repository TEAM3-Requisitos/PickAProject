class PagesController < ApplicationController
	# Bypass authorization check for pages controller.
	skip_authorization_check

	def home
	end
	def about
		@contributors = [
			{
				avatar: "https://avatars1.githubusercontent.com/u/3246666?v=3&s=460",
				name: "Eduardo Brasil",
				role: "Software Configuration Management, developer and frontend",
				git: "https://github.com/EduardoBrasil",
				facebook: "https://www.facebook.com/eduardo.brasil2"
			}, {
				avatar: "https://avatars2.githubusercontent.com/u/11253021?v=3&s=400",
				name: "Luan Guimarães",
				role: "Lead developer and frontend",
				git: "https://github.com/luanguimaraesla",
				facebook:"https://www.facebook.com/luanguimaraesla?fref=ts"
			}, {
				avatar: "https://avatars2.githubusercontent.com/u/5897235?v=3&s=400",
				name: "Felipe Duerno",
				role: "Lead developer and frontend",
				git: "https://github.com/Duerno",
				facebook:"https://www.facebook.com/felipe.duerno?fref=ts"
			}
		]
		@description = "Pick a Project is an application developed by undergraduated students of Software Engineering from the University of Brasília at Brazil. Here, users can create projects and find collaborators for them."
	end
end
