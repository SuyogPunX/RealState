// Basic JS functionality
document.addEventListener('DOMContentLoaded', function() {
    // Smooth scrolling for anchor links
    
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