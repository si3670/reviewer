<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	let MemberModify__submitFormDone = false;
	function MemberModify__submitForm(form) {
		if (MemberModify__submitFormDone) {
			return;
		}

		const deleteProfileImgFileInput = form["deleteFile__member__0__extra__profileImg__1"];
		if (deleteProfileImgFileInput.checked) {
			form["file__member__0__extra__profileImg__1"].value = '';
		}
		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1024 * 1024;
		const profileImgFileInput = form["file__member__0__extra__profileImg__1"];
		if (profileImgFileInput.value) {
			if (profileImgFileInput.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();
				return;
			}
		}

		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwInput.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요.');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.loginPwInput.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다.');
				form.loginPwConfirm.focus();
				return;
			}
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('연락처를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		if (form.loginPwInput.value.length > 0) {
			form.loginPw.value = sha256(form.loginPwInput.value);
			form.loginPwInput.value = '';
			form.loginPwConfirm.value = '';
		}
		form.submit();
		MemberModify__submitFormDone = true;
	}
</script>
<div class="section section-member-modify px-2">
	<div class="container mx-auto">
		<div
			class="mt-20 mb-10 mx-40 card bordered shadow-lg item-bt-1-not-last-child">
			<div class="card-title-2">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>정보</span>
			</div>
			<form method="POST" enctype="multipart/form-data" action="doModify"
				onsubmit="MemberModify__submitForm(this); return false;"
				class="px-28 py-8 mt-4">
				<input type="hidden" name="checkPasswordAuthCode"
					value="${param.checkPasswordAuthCode}">
				<input type="hidden" name="loginPw">
				<div class="form-control flex items-center my-6">
					<img class="w-40 h-40 mb-2 object-cover rounded-full"
						onerror="${rq.loginedMember.removeProfileImgIfNotExistsOnErrorHtmlAttr}"
						src="${rq.loginedMember.profileImgUri}" alt="">
					<div class="filebox">
						<label for="ex_file">프로필사진 선택</label>
						<input accept="image/gif, image/jpeg, image/png" type="file" id="ex_file" name="file__member__0__extra__profileImg__1" >
					</div>
					<div>
						<label class="cursor-pointer label inline-flex">
							<span class="label-text mr-2">이미지 삭제</span>
							<div>
								<input type="checkbox"
									name="deleteFile__member__0__extra__profileImg__1"
									class="checkbox" value="Y">
								<span class="checkbox-mark"></span>
							</div>
						</label>
					</div>
				</div>
				<div class="form-control">
					<label class="label"> 아이디 </label>
					<div class="plain-text">${rq.loginedMember.loginId}</div>
				</div>
				<div class="form-control">
					<label class="label"> 비밀번호 </label>
					<input class="login-form px-3 py-2" type="password" maxlength="20"
						name="loginPwInput" placeholder="비밀번호를 입력해주세요." />
					<input class="login-form brt px-3 py-2" type="password"
						maxlength="20" name="loginPwConfirm"
						placeholder="비밀번호 확인을 입력해주세요." />
				</div>
				<div class="form-control">
					<label class="label"> 이름 </label>
					<input value="${rq.loginedMember.name}"
						class="login-form px-3 py-2" type="text" maxlength="20"
						name="name" placeholder="이름을 입력해주세요." />
				</div>
				<div class="form-control">
					<label class="label"> 닉네임 </label>
					<input value="${rq.loginedMember.nickname}"
						class="login-form px-3 py-2" type="text" maxlength="20"
						name="nickname" placeholder="닉네임을 입력해주세요." />
				</div>
				<div class="form-control">
					<label class="label"> 연락처 </label>
					<input value="${rq.loginedMember.cellphoneNo}"
						class="login-form px-3 py-2" type="tel" maxlength="20"
						name="cellphoneNo" placeholder="연락처를 입력해주세요." />
				</div>
				<div class="form-control">
					<label class="label"> 이메일 </label>
					<input value="${rq.loginedMember.email}"
						class="login-form px-3 py-2" type="email" maxlength="20"
						name="email" placeholder="이메일을 입력해주세요." />
				</div>
				<div class="mt-4 btn-wrap gap-1">
					<button type="submit" href="#"
						class="bg-red-600 hover:bg-gray-600 text-white btn-sm">
						<span>
							<i class="fas fa-user-plus"></i>
						</span>
						&nbsp;
						<span>수정</span>
					</button>
					<a href="../member/myPage"
						class="btn-sm text-red-600 hover:underline">
						<span>
							<i class="fas fa-home"></i>
						</span>
						&nbsp;
						<span class="">마이페이지</span>
					</a>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../part/mainLayoutFoot.jspf"%>
