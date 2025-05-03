// DOM Elements
document.addEventListener('DOMContentLoaded', function() {
    // Modal functionality
    const addPropertyBtn = document.getElementById('addPropertyBtn');
    const propertyModal = document.getElementById('propertyModal');
    const closeBtn = document.querySelector('.close-btn');
    const cancelBtn = document.querySelector('.modal-footer .btn-outline');
    const savePropertyBtn = document.querySelector('.modal-footer .btn-primary');
    const propertyForm = document.getElementById('propertyForm');
    
    // Open modal when Add Property button is clicked
    if (addPropertyBtn) {
        addPropertyBtn.addEventListener('click', function() {
            propertyModal.style.display = 'block';
        });
    }
    
    // Close modal when X button is clicked
    if (closeBtn) {
        closeBtn.addEventListener('click', function() {
            propertyModal.style.display = 'none';
        });
    }
    
    // Close modal when Cancel button is clicked
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function() {
            propertyModal.style.display = 'none';
        });
    }
    
    // Close modal when clicking outside of it
    window.addEventListener('click', function(event) {
        if (event.target === propertyModal) {
            propertyModal.style.display = 'none';
        }
    });
    
    // Handle property form submission
    if (savePropertyBtn && propertyForm) {
        savePropertyBtn.addEventListener('click', function(e) {
            e.preventDefault();
            // Validate form
            if (validatePropertyForm()) {
                // Simulate form submission
                alert('Property saved successfully!');
                propertyModal.style.display = 'none';
                propertyForm.reset();
            }
        });
    }
    
    // Filter functionality
    const applyFiltersBtn = document.querySelector('.filter-actions .btn-primary');
    const resetBtn = document.querySelector('.filter-actions .btn-outline');
    
    if (applyFiltersBtn) {
        applyFiltersBtn.addEventListener('click', function() {
            // Get filter values
            const propertyType = document.querySelector('.filter-item:nth-child(1) select').value;
            const location = document.querySelector('.filter-item:nth-child(2) select').value;
            const minPrice = document.querySelector('.price-range input:first-child').value;
            const maxPrice = document.querySelector('.price-range input:last-child').value;
            const status = document.querySelector('.filter-item:nth-child(4) select').value;
            
            // Apply filters (simulated)
            console.log('Applying filters:', { propertyType, location, minPrice, maxPrice, status });
            alert('Filters applied!');
        });
    }
    
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            // Reset all filter inputs
            const filterInputs = document.querySelectorAll('.filter-item select, .filter-item input');
            filterInputs.forEach(input => {
                if (input.tagName === 'SELECT') {
                    input.selectedIndex = 0;
                } else {
                    input.value = '';
                }
            });
        });
    }
    
    // Table actions functionality
    const viewBtns = document.querySelectorAll('.view-btn');
    const editBtns = document.querySelectorAll('.edit-btn');
    const deleteBtns = document.querySelectorAll('.delete-btn');
    
    viewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const propertyName = this.closest('tr').querySelector('.property-item div').textContent;
            alert(`Viewing details for: ${propertyName}`);
        });
    });
    
    editBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const propertyName = this.closest('tr').querySelector('.property-item div').textContent;
            // Open modal with property data
            propertyModal.style.display = 'block';
            document.querySelector('.modal-header h2').textContent = `Edit Property: ${propertyName}`;
            // Populate form with property data (simulated)
        });
    });
    
    deleteBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const propertyName = this.closest('tr').querySelector('.property-item div').textContent;
            if (confirm(`Are you sure you want to delete "${propertyName}"?`)) {
                // Delete property logic (simulated)
                this.closest('tr').remove();
                alert(`${propertyName} has been deleted.`);
            }
        });
    });
    
    // Pagination functionality
    const paginationBtns = document.querySelectorAll('.pagination .btn-page');
    
    paginationBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // Remove active class from all buttons
            paginationBtns.forEach(b => b.classList.remove('active'));
            // Add active class to clicked button
            this.classList.add('active');
            
            // Handle previous/next logic
            if (this.textContent === 'Previous') {
                const activePage = document.querySelector('.pagination .active');
                if (activePage && activePage.previousElementSibling && 
                    activePage.previousElementSibling.textContent !== 'Previous') {
                    activePage.previousElementSibling.click();
                }
            } else if (this.textContent === 'Next') {
                const activePage = document.querySelector('.pagination .active');
                if (activePage && activePage.nextElementSibling && 
                    activePage.nextElementSibling.textContent !== 'Next') {
                    activePage.nextElementSibling.click();
                }
            }
            
            // Simulated page change
            console.log(`Navigated to page: ${this.textContent}`);
        });
    });
    
    // Search functionality
    const searchInput = document.querySelector('.search-box input');
    
    if (searchInput) {
        searchInput.addEventListener('keyup', function(e) {
            if (e.key === 'Enter') {
                const searchTerm = this.value.toLowerCase().trim();
                // Search logic (simulated)
                console.log(`Searching for: ${searchTerm}`);
                
                if (searchTerm) {
                    const tableRows = document.querySelectorAll('tbody tr');
                    tableRows.forEach(row => {
                        const propertyName = row.querySelector('.property-item div').textContent.toLowerCase();
                        const propertyType = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                        const location = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                        
                        if (propertyName.includes(searchTerm) || 
                            propertyType.includes(searchTerm) || 
                            location.includes(searchTerm)) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                } else {
                    // Show all rows if search is empty
                    const tableRows = document.querySelectorAll('tbody tr');
                    tableRows.forEach(row => {
                        row.style.display = '';
                    });
                }
            }
        });
    }
    // User profile popup functionality
    setupUserProfilePopup()
    
    
    // Pagination configuration
    const itemsPerPage = 5;
    const totalItems = 25; // Total number of properties (simulated)
    const totalPages = Math.ceil(totalItems / itemsPerPage);
    let currentPage = 1;
    
    // Elements
    const paginationContainer = document.getElementById('pagination');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const paginationNumbers = document.querySelector('.pagination-numbers');
    const showingStart = document.getElementById('showing-start');
    const showingEnd = document.getElementById('showing-end');
    const totalItemsElement = document.getElementById('total-items');
    
    // Initialize pagination
    function initPagination() {
        // Set total items count
        if (totalItemsElement) {
            totalItemsElement.textContent = totalItems;
        }
        
        // Clear any existing pagination numbers
        if (paginationNumbers) {
            paginationNumbers.innerHTML = '';
            
            // Generate page number buttons
            for (let i = 1; i <= totalPages; i++) {
                const pageBtn = document.createElement('button');
                pageBtn.className = 'pagination-btn';
                pageBtn.textContent = i;
                
                if (i === currentPage) {
                    pageBtn.classList.add('active');
                }
                
                pageBtn.addEventListener('click', function() {
                    goToPage(i);
                });
                
                paginationNumbers.appendChild(pageBtn);
            }
        }
        
        // Update prev/next buttons
        updatePaginationControls();
        
        // Load first page of data
        loadPageData(currentPage);
    }
    
    // Go to specific page
    function goToPage(pageNum) {
        currentPage = pageNum;
        
        // Update active page button
        const pageButtons = document.querySelectorAll('.pagination-numbers .pagination-btn');
        pageButtons.forEach(btn => {
            btn.classList.remove('active');
            if (parseInt(btn.textContent) === currentPage) {
                btn.classList.add('active');
            }
        });
        
        // Update controls
        updatePaginationControls();
        
        // Load page data
        loadPageData(currentPage);
    }
    
    // Update pagination controls (prev/next buttons)
    function updatePaginationControls() {
        if (prevBtn) {
            prevBtn.disabled = currentPage === 1;
        }
        
        if (nextBtn) {
            nextBtn.disabled = currentPage === totalPages;
        }
        
        // Update showing text
        if (showingStart && showingEnd) {
            const start = (currentPage - 1) * itemsPerPage + 1;
            const end = Math.min(currentPage * itemsPerPage, totalItems);
            
            showingStart.textContent = start;
            showingEnd.textContent = end;
        }
    }
    
    // Load page data (simulated)
    function loadPageData(page) {
        console.log(`Loading page ${page} data...`);
        
        // In a real application, this would fetch data from an API
        // For this demo, we'll simulate loading by hiding/showing existing rows
        
        const tableRows = document.querySelectorAll('tbody tr');
        
        // Simple simulation: For demo purposes only
        tableRows.forEach((row, index) => {
            const startIdx = (page - 1) * itemsPerPage;
            const endIdx = page * itemsPerPage - 1;
            
            if (index >= startIdx && index <= endIdx) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
    
    // Add event listeners for prev/next buttons
    if (prevBtn) {
        prevBtn.addEventListener('click', function() {
            if (currentPage > 1) {
                goToPage(currentPage - 1);
            }
        });
    }
    
    if (nextBtn) {
        nextBtn.addEventListener('click', function() {
            if (currentPage < totalPages) {
                goToPage(currentPage + 1);
            }
        });
    }
    
    // Initialize pagination on page load
    initPagination();
    
    
});

// Form validation function
function validatePropertyForm() {
    const title = document.querySelector('input[placeholder="Enter property title"]').value;
    const propertyType = document.querySelector('select:has(option[value="apartment"])').value;
    const status = document.querySelector('select:has(option[value="sale"])').value;
    const price = document.querySelector('input[placeholder="Enter price"]').value;
    
    if (!title) {
        alert('Please enter a property title');
        return false;
    }
    
    if (!propertyType) {
        alert('Please select a property type');
        return false;
    }
    
    if (!status) {
        alert('Please select a status');
        return false;
    }
    
    if (!price) {
        alert('Please enter a price');
        return false;
    }
    
    return true;
}
/**
 * Sets up the user profile popup functionality
 */
function setupUserProfilePopup() {
    const userProfile = document.querySelector('.user-profile');
    
    if (userProfile) {
        // Create popup element
        const popup = document.createElement('div');
        popup.className = 'profile-popup';
        popup.innerHTML = `
            <div class="profile-popup-content">
                <div class="profile-header">
                    <div class="profile-avatar">A</div>
                    <div class="profile-info">
                        <h3>Admin User</h3>
                        <p>admin@dreamhome.com.np</p>
                    </div>
                </div>
                <div class="profile-menu">
                    <a href="../pages/profile.html" class="profile-menu-item">
                        <span>👤</span> My Profile
                    </a>
                    <hr>
                    <a href="../index.html" class="profile-menu-item">
                        <span>🚪</span> Logout
                    </a>
                </div>
            </div>
        `;
        
        // Add styles for popup
        const style = document.createElement('style');
        style.textContent = `
            .profile-popup {
                position: absolute;
                top: 50px;
                right: 0;
                width: 250px;
                background-color: var(--white);
                border-radius: 0.3rem;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                z-index: 100;
                display: none;
            }
            
            .profile-popup.show {
                display: block;
                animation: fadeIn 0.2s ease-out;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            .profile-popup-content {
                padding: 1rem;
            }
            
            .profile-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid var(--border);
            }
            
            .profile-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: var(--secondary);
                color: var(--white);
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 1.25rem;
            }
            
            .profile-info h3 {
                margin: 0;
                font-size: 1rem;
            }
            
            .profile-info p {
                margin: 0;
                font-size: 0.875rem;
                color: #6c757d;
            }
            
            .profile-menu {
                margin-top: 1rem;
            }
            
            .profile-menu-item {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding: 0.75rem 0.5rem;
                border-radius: 0.3rem;
                color: var(--dark);
                text-decoration: none;
                transition: all 0.3s ease;
            }
            
            .profile-menu-item:hover {
                background-color: var(--light-bg);
            }
            
            .profile-menu hr {
                border: none;
                border-top: 1px solid var(--border);
                margin: 0.5rem 0;
            }
        `;
        
        document.head.appendChild(style);
        document.body.appendChild(popup);
        
        // Toggle popup visibility on click
        userProfile.addEventListener('click', function(e) {
            e.stopPropagation();
            popup.classList.toggle('show');
        });
        
        // Close popup when clicking outside of it
        document.addEventListener('click', function(e) {
            if (!popup.contains(e.target) && !userProfile.contains(e.target)) {
                popup.classList.remove('show');
            }
        });
    }
}

