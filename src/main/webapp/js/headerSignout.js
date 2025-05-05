document.addEventListener('DOMContentLoaded', function() {
       const profileIcon = document.getElementById('profileIcon');
       if (profileIcon) {
           const profilePopup = document.getElementById('profilePopup');
           const overlay = document.getElementById('overlay');
           
           // Toggle popup when profile icon is clicked
           profileIcon.addEventListener('click', function(e) {
               e.stopPropagation(); // Prevent event bubbling
               profilePopup.classList.toggle('active');
               overlay.classList.toggle('active');
           });
           
           // Close popup when clicking outside of it
           document.addEventListener('click', function(e) {
               if (profilePopup.classList.contains('active') && !profilePopup.contains(e.target)) {
                   profilePopup.classList.remove('active');
                   overlay.classList.remove('active');
               }
           });
           
           // Prevent popup from closing when clicking inside it
           profilePopup.addEventListener('click', function(e) {
               e.stopPropagation();
           });
           
           // Add specific behavior for signout link
           const signoutLink = document.getElementById('signoutLink');
           if (signoutLink) {
               signoutLink.addEventListener('click', function(e) {
                   // Add a small delay to make the signout more reliable
                   e.preventDefault();
                   const href = this.getAttribute('href');
                   setTimeout(function() {
                       window.location.href = href;
                   }, 100);
               });
           }
       }
   });