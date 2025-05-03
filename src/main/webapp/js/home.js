// Basic JS functionality
document.addEventListener('DOMContentLoaded', function() {
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const target = document.querySelector(targetId);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Property card hover effect
    const propertyCards = document.querySelectorAll('.property-card');
    propertyCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.cursor = 'pointer';
        });
        
        card.addEventListener('click', function() {
            alert('Property details page would open here!');
        });
    });
    
    // Category card click effect
    const categoryCards = document.querySelectorAll('.category-card');
    categoryCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.cursor = 'pointer';
        });
        
        card.addEventListener('click', function() {
            const category = this.querySelector('.category-name').textContent;
            alert('Browsing ' + category + ' category');
        });
    });
    
    // Registration and sign-in buttons
    const registerBtn = document.querySelector('.btn-primary');
    const signInBtn = document.querySelector('.btn-outline');
    
    registerBtn.addEventListener('click', function() {
        alert('Registration form would open here!');
    });
    
    signInBtn.addEventListener('click', function() {
        alert('Sign in form would open here!');
    });
    
    // Mobile nav toggle (would be expanded in a real implementation)
    const mobileBreakpoint = 768;
    
    function checkScreenSize() {
        if (window.innerWidth <= mobileBreakpoint) {
            // Mobile navigation setup would go here
        }
    }
    
    window.addEventListener('resize', checkScreenSize);
    checkScreenSize();
});