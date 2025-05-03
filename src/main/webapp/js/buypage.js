document.addEventListener('DOMContentLoaded', function() {
    // Property Card Interactions
    const propertyCards = document.querySelectorAll('.property-card');
    
    propertyCards.forEach(card => {
        card.addEventListener('click', function(e) {
            // Don't navigate if user clicked on a button or link inside the card
            if (e.target.tagName === 'BUTTON' || e.target.tagName === 'A') {
                return;
            }
            
            // Get property ID or unique identifier (in a real app, this would come from data attributes)
            const propertyTitle = this.querySelector('.property-title').textContent;
            console.log(`Navigating to details page for: ${propertyTitle}`);
            
            // In a real application, you would redirect to the property detail page
            // window.location.href = `/properties/${propertyId}`;
        });
        
        // Add hover effect
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
            this.style.boxShadow = '0 10px 20px rgba(0,0,0,0.1)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = '';
            this.style.boxShadow = '';
        });
    });

    // Filter Functionality
    const filterBtn = document.querySelector('.filter-btn');
    const resetBtn = document.querySelector('.reset-btn');
    
    if (filterBtn) {
        filterBtn.addEventListener('click', function() {
            const priceMin = document.querySelector('.price-inputs input:first-child').value;
            const priceMax = document.querySelector('.price-inputs input:last-child').value;
            const selectedTypes = Array.from(document.querySelectorAll('.filter-group:nth-child(2) input[type="checkbox"]:checked'))
                .map(cb => cb.nextElementSibling.textContent.trim());
            
            console.log('Applying filters:', {
                priceMin,
                priceMax,
                propertyTypes: selectedTypes
            });
            
            // In a real app, this would filter properties via AJAX or update the DOM
            alert('Filters applied! (See console for details)');
        });
    }
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            // Reset all filter inputs
            document.querySelectorAll('.filter-input').forEach(input => {
                input.value = '';
            });
            
            document.querySelectorAll('.filter-group input[type="checkbox"]').forEach(cb => {
                cb.checked = false;
            });
            
            console.log('Filters reset');
            // In a real app, this would reset the property listing
            alert('Filters reset!');
        });
    }

    // Sort Functionality
    const sortSelect = document.querySelector('.sort-select');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            const sortValue = this.value;
            console.log('Sorting by:', sortValue);
            
            // In a real app, this would re-sort the properties
            alert(`Properties sorted by: ${sortValue}`);
        });
    }

    // Pagination
    const paginationItems = document.querySelectorAll('.pagination-item');
    paginationItems.forEach(item => {
        item.addEventListener('click', function() {
            // Remove active class from all items
            paginationItems.forEach(i => i.classList.remove('active'));
            
            // Add active class to clicked item (unless it's the arrow)
            if (!this.textContent.includes('→')) {
                this.classList.add('active');
            }
            
            const pageNum = this.textContent;
            console.log(`Loading page ${pageNum}`);
            
            // In a real app, this would load the selected page
            alert(`Loading page ${pageNum}`);
        });
    });

    

    // Mobile Menu Toggle (would need HTML element added)
    // const mobileMenuToggle = document.createElement('div');
    // mobileMenuToggle.className = 'mobile-menu-toggle';
    // mobileMenuToggle.innerHTML = '☰';
    // document.querySelector('header').prepend(mobileMenuToggle);
    
    // mobileMenuToggle.addEventListener('click', function() {
    //     const nav = document.querySelector('nav');
    //     nav.style.display = nav.style.display === 'block' ? 'none' : 'block';
    // });

    // Responsive adjustments
    function handleResize() {
        const nav = document.querySelector('nav');
        if (window.innerWidth > 768) {
            nav.style.display = '';
        }
    }
    
    window.addEventListener('resize', handleResize);

    // Newsletter Form
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input').value;
            
            if (email && email.includes('@')) {
                console.log('Subscribing email:', email);
                alert('Thank you for subscribing!');
                this.querySelector('input').value = '';
            } else {
                alert('Please enter a valid email address');
            }
        });
    }

    // Notification Bell Interaction
    const notificationBell = document.querySelector('.notification');
    if (notificationBell) {
        notificationBell.addEventListener('click', function() {
            console.log('Showing notifications');
            this.querySelector('.notification-dot').style.display = 'none';
            // In a real app, show notifications dropdown
            alert('You have 3 new notifications');
        });
    }

    // Shopping Cart Interaction
    const cart = document.querySelector('.cart');
    if (cart) {
        cart.addEventListener('click', function() {
            console.log('Showing cart');
            // In a real app, show cart contents
            alert('Your cart is empty');
        });
    }

    // Auth Buttons
    const signInBtn = document.querySelector('.sign-in');
    const registerBtn = document.querySelector('.register');
    
    if (signInBtn) {
        signInBtn.addEventListener('click', function() {
            console.log('Sign in clicked');
            window.location.href = '/login';
        });
    }
    
    if (registerBtn) {
        registerBtn.addEventListener('click', function() {
            console.log('Register clicked');
            window.location.href = '/register';
        });
    }
});