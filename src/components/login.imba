import {Page} from './page'
import {User} from '../models/user'
import { loadResource, formatDate, encode, postResource } from './util'

export tag Login < Page
	def login
		var user = User.new();
		user.email = @email
		user.password = @password
		user = await postResource("users/login", user, @headers)
		window:localStorage.setItem('user-conduit', JSON.stringify(user:user)) if user:user != @user
		window:location:href = "/"
		self
	def render
		<self>
			<div .container .page>
				<div .row>
					<div .col-md-6 .offset-md-3 .col-xs-12>
						<h1 .text-xs-center> "Sign in"
						<p .text-xs-center>
							<a route-to='/register'> "Need an account?"
						<form :submit.prevent.login>
							<fieldset>
								<fieldset .form-group>
									<input[@email] .form-control .form-control-lg type="email" placeholder="Email">
								<fieldset .form-group>
									<input[@password] .form-control .form-control-lg type="password" placeholder="Password">
								<button .btn .btn-lg .btn-primary .pull-xs-right type="submit"> "Sign in"