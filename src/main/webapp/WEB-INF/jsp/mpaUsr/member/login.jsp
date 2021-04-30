<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/mainLayoutHead.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const LoginForm__checkAndSubmitDone = false;
	function LoginForm__checkAndSubmit(form) {
		if (LoginForm__checkAndSubmitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}

		form.loginPwInput.value = form.loginPwInput.value.trim();

		if (form.loginPwInput.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPwInput.focus();
			return;
		}

		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';

		form.submit();
		LoginForm__checkAndSubmitDone = true;
	}
</script>
<section
	class="section-Login flex items-center min-h-screen bg-white dark:bg-gray-900">
	<div
		class="container mx-auto min-h-screen flex items-center justify-center">
		<div class="max-w-md mx-auto my-10">
			<div class="logo-bar flex justify-center">
				<h1 class="text-5xl">login</h1>
			</div>
			<div class="mt-4">
				<form action="doLogin" method="post"
					onsubmit="LoginForm__checkAndSubmit(this); return false;">
					<input type="hidden" name="redirectUri" value="/" />
					<input type="hidden" name="loginPw" />
					<div class="mb-6">
						<input
							class="login-form w-full px-3 py-2"
							autofocus="autofocus" type="text" placeholder="id" name="loginId"
							maxlength="20" />
						<input
							class="login-form brt w-full px-3 py-2"
							autofocus="autofocus" type="password" placeholder="password"
							name="loginPwInput" maxlength="20" />
					</div>
					<div class="mb-6">
						<button
							class="w-full px-2 py-1 text-white bg-red-400 rounded-md focus:bg-red-600 focus:outline-none"
							type="sumit">로그인</button>
					</div>

					<div class="flex">
						<a href="../member/join"
							class="text-indigo-400 focus:outline-none focus:underline focus:text-indigo-500 dark:focus:border-indigo-800"
							type="sumit">SignUp</a>
						<div class="flex-grow"></div>

						<a href="../member/findLoginInfo"
							class="text-indigo-400 focus:outline-none focus:underline focus:text-indigo-500 dark:focus:border-indigo-800"
							type="sumit">find Id/Password</a>

					</div>



				</form>
			</div>
		</div>

	</div>
</section>
<%@ include file="../part/mainLayoutFoot.jspf"%>
