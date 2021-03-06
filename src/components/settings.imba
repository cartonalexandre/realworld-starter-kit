import {Page} from './page'
import {User} from '../models/user'
import { api } from './util'

export tag Settings < Page
	prop user
	@user = {}
	def load
		api("user", "get", null, @headers)
			.then do |data|
				@user = data:user
				render
			.catch do |result|
				console.log result
	def update
		api("user", "put", {"user": @user}, @headers)
			.then do |data|
				@user = data:user
				window:location:href = "/"
			.catch do |result|
				console.log result
	def logout
		delete @currentUser
		window:localStorage.removeItem('user-conduit')
		window:location:href = "/"
	def render
		<self>
			<div .settings-page>
				<div .container .page>
					<div .row>
						<div .col-md-6 .offset-md-3 .col-xs-12>
							<h1 .text-xs-center> "Your Settings"
							<form :submit.prevent.update>
								<fieldset>
									<fieldset .form-group>
										<input[user:image] .form-control type="text" placeholder="URL of profile picture">
									<fieldset .form-group>
										<input[user:username] .form-control .form-control-lg type="text" placeholder="Your Name">
									<fieldset .form-group>
										<textarea[user:bio] .form-control .form-control-lg rows="8" placeholder="Short bio about you">
									<fieldset .form-group>
										<input[user:email] .form-control .form-control-lg type="text" placeholder="Email">
									<fieldset .form-group>
										<input[user:password] .form-control .form-control-lg type="password" placeholder="Password">
									<button .btn .btn-lg .btn-primary .pull-xs-right type="submit"> "Update Settings"
							<hr>
							<button .btn .btn-outline-danger :click.logout> "Or click here to logout."