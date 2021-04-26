<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../part/head.jspf"%>

<script>
	const FindLoginIdForm__checkAndSubmitDone = false;
	function FindLoginIdForm__checkAndSubmit(form) {
		if (FindLoginIdForm__checkAndSubmitDone) {
			return;
		}

		form.name.value = form.name.value.trim();

		if (form.FindLoginIdFormId.value.length == 0) {
			alert('name 입력해주세요');
			form.name.focus();
			return;
		}

		if (form.email.value.length == 0) {
			alert('email 입력해주세요');
			form.email.focus();
			return;
		}
		form.submit();
		FindLoginIdForm__checkAndSubmitDone = true;
	}
</script>
<section
	class="section-Login flex items-center bg-white dark:bg-gray-900 mt-10">
	<div
		class="container mx-auto flex items-center justify-center">
		<div class="max-w-md mx-auto">
			<div class="logo-bar flex justify-center mt-3">
				<a href="#" class="img-box w-28">
					<img src="http://localhost:8044/resource/imgs/Cellar1.png" alt="" />
				</a>
				<span class="text-2xl pt-2">find Id/PassWord</span>
			</div>
			<div class="m-7">
				<form
					class="bg-white shadow-md rounded w-max px-10 pt-6 pb-8 mb-4 flex flex-col"
					action="doFindLoginId" method="post"
					onsubmit="FindLoginIdForm__checkAndSubmit(this); return false;">

					<h2 class="con">아이디 찾기</h2>

					<div class="mb-6">
						<label class="block mb-2 text-sm text-gray-600 dark:text-gray-400">이름</label>
						<input
							class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md "
							autofocus="autofocus" type="text" placeholder="name를 입력해주세요."
							name="name" maxlength="20" />
					</div>
					<div class="mb-6">
						<label class="block mb-2 text-sm text-gray-600 dark:text-gray-400">email</label>
						<input
							class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md "
							autofocus="autofocus" type="email" placeholder="email를 입력해주세요."
							name="email" maxlength="20" />
					</div>
					<div class="mb-6">
						<button
							class="w-full px-2 py-1 text-white bg-red-400 rounded-md focus:bg-red-600 focus:outline-none"
							type="sumit">아이디 찾기</button>
					</div>

					<hr />
					<a onclick="history.back();"
						class="text-center w-full px-2 py-1 text-white bg-purple-400 rounded-md focus:bg-yellow-700 focus:outline-none">뒤로가기</a>
				</form>

		</div>

	</div>
</section>




<script>
	const FindLoginPwForm__checkAndSubmitDone = false;
	function FindLoginPwForm__checkAndSubmit(form) {
		if (FindLoginPwForm__checkAndSubmitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.FindLoginPwFormId.value.length == 0) {
			alert('id 입력해주세요');
			form.loginId.focus();
			return;
		}

		if (form.email.value.length == 0) {
			alert('email 입력해주세요');
			form.email.focus();
			return;
		}
		form.submit();
		FindLoginPwForm__checkAndSubmitDone = true;
	}
</script>

<section
	class="section-Login flex items-center bg-white dark:bg-gray-900">

	<div
		class="container mx-auto flex items-center justify-center">
		<div class="max-w-md mx-auto">

			<form
				class="bg-white shadow-md rounded w-max px-10 pt-6 pb-8 mb-4 flex flex-col"
				action="doFindLoginPw" method="post"
				onsubmit="FindLoginPwForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="replaceUrl" value="../member/login" />

				<h2 class="con">비밀번호 찾기</h2>

				<div class="mb-6">
					<label class="block mb-2 text-sm text-gray-600 dark:text-gray-400">아이디</label>
					<input
						class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md "
						autofocus="autofocus" type="text" placeholder="id를 입력해주세요."
						name="loginId" maxlength="20" />
				</div>
				<div class="mb-6">
					<label class="block mb-2 text-sm text-gray-600 dark:text-gray-400">email</label>
					<input
						class="w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md "
						autofocus="autofocus" type="email" placeholder="email를 입력해주세요."
						name="email" maxlength="20" />
				</div>
				<div class="mb-6">
					<button
						class="w-full px-2 py-1 text-white bg-red-400 rounded-md focus:bg-red-600 focus:outline-none"
						type="sumit">비밀번호 찾기</button>
				</div>

				<hr />
				<a onclick="history.back();"
					class="text-center w-full px-2 py-1 text-white bg-purple-400 rounded-md focus:bg-yellow-700 focus:outline-none">뒤로가기</a>
			</form>
		</div>
	</div>
</section>


<%@ include file="../part/foot.jspf"%>
