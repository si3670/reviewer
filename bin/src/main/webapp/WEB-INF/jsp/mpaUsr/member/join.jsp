<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>


<script>
	let JoinForm__checkAndSubmitDone = false;

	function JoinForm__checkAndSubmit(form) {
		if (JoinForm__checkAndSubmitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('로그인아이디를 입력해주세요.');
			form.loginId.focus();

			return;
		}

		form.loginPwInput.value = form.loginPwInput.value.trim();

		if (form.loginPwInput.value.length == 0) {
			alert('로그인비번을 입력해주세요.');
			form.loginPwInput.focus();

			return;
		}

		if (form.loginPwConfirm.value.length == 0) {
			alert('로그인비번 확인을 입력해주세요.');
			form.loginPwConfirm.focus();

			return;
		}

		if (form.loginPwInput.value != form.loginPwConfirm.value) {
			alert('로그인비번이 일치하지 않습니다.');
			form.loginPwConfirm.focus();

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			alert('별명을 입력해주세요.');
			form.nickname.focus();

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();

			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();

		if (form.cellphoneNo.value.length == 0) {
			alert('휴대전화번호를 입력해주세요.');
			form.cellphoneNo.focus();

			return;
		}

		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		JoinForm__checkAndSubmitDone = true;
	}
</script>
<section class="section-login">
	<div
		class="container mx-auto min-h-screen flex items-center justify-center">
		<div class="mt-16">
			<div class="logo-bar flex justify-center mt-6">
				<div class="page-title">Join</div>
			</div>
			<form class="formLogin px-8 pt-6 pb-8 mt-4" action="doJoin"
				method="POST" enctype="multipart/form-data"
				onsubmit="JoinForm__checkAndSubmit(this); return false;">
				<input type="hidden" name="loginPw">

				<div class="mb-4">
					<div class="p-1">
						<span>프로필 사진</span>
						<i aria-hidden="true" class="icon-required"></i>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="file" name="file__member__0__extra__profileImg__1"
							placeholder="프로필 이미지를 선택해주세요." />
					</div>
				</div>


				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:flex-grow">
						<input class="inputLoginId login-form w-full px-3 py-2"
							autofocus="autofocus" type="text" placeholder="아이디"
							name="loginId" maxlength="20" />

						<input class="login-form brt w-full px-3 py-2"
							autofocus="autofocus" type="password" placeholder="비밀번호"
							name="loginPwInput" maxlength="20" />

						<input class="login-form brt w-full px-3 py-2"
							autofocus="autofocus" type="password" placeholder="비밀번호확인"
							name="loginPwConfirm" maxlength="20" />
					</div>
				</div>

				<div class="flex-col mb-4 md:flex-row">
					<div class="p-1">
						<span>이름</span>
						<i aria-hidden="true" class="icon-required"></i>
					</div>
					<div class="p-1 md:flex-grow">
						<input class="login-form w-full px-3 py-2" autofocus="autofocus"
							type="text" placeholder="이름을(를) 입력하세요" name="name" maxlength="20" />
						<input class="login-form brt w-full px-3 py-2"
							autofocus="autofocus" type="text" placeholder="닉네임을(를) 입력하세요"
							name="nickname" maxlength="20" />
					</div>
				</div>

				<div class="mb-4">
					<div class="p-1">
						<span>이메일</span>
						<i aria-hidden="true" class="icon-required"></i>
					</div>
					<div class="p-1 md:flex-grow">
						<input class="login-form w-full px-3 py-2" autofocus="autofocus"
							type="email" placeholder="이메일" name="email" maxlength="100" />
					</div>
				</div>
				<div class="mb-4">
					<div class="p-1">
						<span>연락처</span>
						<i aria-hidden="true" class="icon-required"></i>
					</div>
					<div class="p-1 md:flex-grow">
						<input class="login-form w-full px-3 py-2" autofocus="autofocus"
							type="tel" placeholder="연락처(- 없이 입력해주세요.)" name="cellphoneNo"
							maxlength="11" />
					</div>
				</div>




				<div class="p-1">
					<input
						class="btn-primary bg-red-400 hover:bg-red-600 text-white font-bold py-2 px-4 w-full"
						type="submit" value="회원가입" />
				</div>

			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>
