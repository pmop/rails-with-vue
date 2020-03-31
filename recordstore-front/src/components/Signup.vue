<template>
<body class='bg-gray-100'>
	<!-- mobile first -->
	<div class='grid grid-cols-1 lg:grid-cols-2'>
		<div class='bg-blue-800 lg:min-h-screen
			lg:flex lg:items-center p-8 sm:p-12'>
			<div class='flex-grow'>
				<h1 class='text-white text-center text-2xl sm:text-5xl mb-2'>
					Hello There!</h1>
			</div>
		</div>
		<div class='lg:min-h=screen lg:flex lg:items-center p-12 lg:p-24 xl:p-48'>
			<div class='flex-grow bg-white shadow-lg rounded-md border border-gray-300 p-8'>
			<form class='flex-col w-full mt-8' @submit.prevent='signin'>

				<input class='flex-1 w-full input-default'
				type='email' id='email' name='email'
				placeholder='Email' v-model='email'>

				<input class='flex-1 w-full input-default mt-4'
				type='email' id='email_confirmation' name='email_confirmation'
				placeholder='Email Confirmation' v-model='email'>

				<input class='flex-1 w-full input-default mt-4'
				type='password' id='password' name='password'
				placeholder='Password' v-model='password'>

				<input class='flex-1 w-full input-default mt-4'
				type='password' id='password_confirmation'
				name='password_confirmation'
				placeholder='Password Confirmation' v-model='password'>

				<button type='submit' class='flex-shrink-0 btn btn-blue mt-4'>
					Sign Up
				</button>
				<div class='mt-4 text-red text-semibold'>
				<router-link to='/'><span class='text-red-500 text-semibold'>Or, Sign in</span>
					</router-link>
				</div>
			</form>
			</div>
		</div>
	</div>
</body>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      email_confirmation: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signup ()
	{
		this.$http.plain.post('/signup',
		{
			email: this.email,
			email_confirmation: this.email_confirmation,
			password: this.password,
			password_confirmation: this.password_confirmation
		}).then(response => this.signupSuccessful(response)
		).catch(error => this.signupFailed(error))
    },
    signupSuccessful (response)
	{
		if (!response.data.csrf) {
			this.signupFailed(response)
			return
		}
		localStorage.csrf = response.data.csrf
		localStorage.signIn = true
		this.error = ''
		this.$router.replace('/records')
	},
    signupFailed (error)
	{
		this.error = (error.response && error.response.data &&
				error.response.data.error) || 'Something went wrong.'
		delete localStorage.csrf
		delete localStorage.signedIn
	},
	checkSignedIn () {
		if (localStorage.signedIn) {
			this.$router.replace('/records')
		}
	}
  }
}
</script>
