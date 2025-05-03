<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload Photo</title>
</head>
<body>
<h2>Upload your photo</h2>

<form action="${pageContext.request.contextPath}/UploadImage" 
      method="post" 
      enctype="multipart/form-data">
    
    <input type="file" name="image" accept="image/*" required /><br><br>
    
    <input type="submit" value="Upload Image" />

</form>
<h2>Uploaded photos</h2>
<img src ="${path}" alt = "Uploaded images"/>
</body>
</html>