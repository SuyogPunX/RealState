document.addEventListener('DOMContentLoaded', function() {
    // Property card hover effects
    const propertyCards = document.querySelectorAll('.property-card');
    propertyCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.cursor = 'pointer';
        });
        
        card.addEventListener('click', function() {
            // Get property ID (you'll need to add this as a data attribute in your JSP)
            const propertyId = this.getAttribute('data-property-id');
            if (propertyId) {
                window.location.href = `${window.location.origin}/property-details?id=${propertyId}`;
            }
        });
    });
    
    // Form validation
    const filterForm = document.getElementById('filterForm');
    if (filterForm) {
        filterForm.addEventListener('submit', function(e) {
            // Validate numeric inputs
            const numericInputs = this.querySelectorAll('input[type="text"]');
            numericInputs.forEach(input => {
                if (input.value && !/^\d+(\.\d+)?$/.test(input.value)) {
                    e.preventDefault();
                    alert('Please enter valid numbers for price and area fields.');
                    input.focus();
                    return false;
                }
            });
            
            // Validate min/max values
            const minPrice = document.querySelector('input[name="minPrice"]');
            const maxPrice = document.querySelector('input[name="maxPrice"]');
            
            if (minPrice && maxPrice && minPrice.value && maxPrice.value) {
                if (parseFloat(minPrice.value) > parseFloat(maxPrice.value)) {
                    e.preventDefault();
                    alert('Minimum price should be less than maximum price.');
                    minPrice.focus();
                    return false;
                }
            }
            
            const minArea = document.querySelector('input[name="minArea"]');
            const maxArea = document.querySelector('input[name="maxArea"]');
            
            if (minArea && maxArea && minArea.value && maxArea.value) {
                if (parseFloat(minArea.value) > parseFloat(maxArea.value)) {
                    e.preventDefault();
                    alert('Minimum area should be less than maximum area.');
                    minArea.focus();
                    return false;
                }
            }
        });
    }

    // Lazy loading for property images
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    const src = img.getAttribute('data-src');
                    if (src) {
                        img.style.backgroundImage = `url(${src})`;
                        img.removeAttribute('data-src');
                    }
                    imageObserver.unobserve(img);
                }
            });
        });

        document.querySelectorAll('.property-image[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }
    
    // Enhance select dropdowns
    const enhanceSelect = (select) => {
        select.addEventListener('focus', function() {
            this.classList.add('focused');
        });
        
        select.addEventListener('blur', function() {
            this.classList.remove('focused');
        });
    };
    
    document.querySelectorAll('select').forEach(select => {
        enhanceSelect(select);
    });
    
    // Mobile-friendly filter toggle
    const createFilterToggle = () => {
        if (window.innerWidth <= 900) {
            const filterSidebar = document.querySelector('.filter-sidebar');
            const filterTitle = document.querySelector('.filter-title');
            
            if (filterSidebar && filterTitle) {
                filterTitle.innerHTML += ' <span class="toggle-icon">▼</span>';
                filterTitle.style.cursor = 'pointer';
                
                const filterGroups = document.querySelectorAll('.filter-group');
                const filterButtons = document.querySelectorAll('.filter-btn, .reset-btn');
                
                // Initially hide filter groups on mobile
                filterGroups.forEach(group => {
                    group.style.display = 'none';
                });
                
                filterButtons.forEach(button => {
                    button.style.display = 'none';
                });
                
                filterTitle.addEventListener('click', function() {
                    const icon = this.querySelector('.toggle-icon');
                    const isVisible = filterGroups[0].style.display !== 'none';
                    
                    filterGroups.forEach(group => {
                        group.style.display = isVisible ? 'none' : 'block';
                    });
                    
                    filterButtons.forEach(button => {
                        button.style.display = isVisible ? 'none' : 'block';
                    });
                    
                    icon.textContent = isVisible ? '▼' : '▲';
                });
            }
        }
    };
    
    // Call the function on page load
    createFilterToggle();
    
    // And also on window resize
    window.addEventListener('resize', createFilterToggle);
});