document.addEventListener('DOMContentLoaded', function() {
    // User profile popup functionality
    setupUserProfilePopup();
    
    // Make stat cards clickable
    setupStatCardNavigation();
    
    // Initialize pagination
    initializePagination();
});

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
                    <a href="signout.html" class="profile-menu-item">
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

/**
 * Makes the statistic cards clickable to navigate to respective pages
 */
function setupStatCardNavigation() {
    const statusCards = document.querySelectorAll('.status-card');
    
    if (statusCards.length > 0) {
        // Map cards to their target pages
        const cardTargets = {
            'Total Properties': '../pages/properties.html',
            'Total Users': '../pages/users.html',
            'Sales Revenue': '../pages/transaction.html',
            'New Inquiries': '../pages/inquaries.html'
        };
        
        statusCards.forEach(card => {
            const cardTitle = card.querySelector('.status-card-title');
            
            if (cardTitle && cardTargets[cardTitle.textContent]) {
                // Make the card clickable
                card.style.cursor = 'pointer';
                
                // Add hover effect
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 5px 15px rgba(0, 0, 0, 0.1)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.05)';
                });
                
                // Add click event to navigate
                card.addEventListener('click', function() {
                    window.location.href = cardTargets[cardTitle.textContent];
                });
                
                // Add transition for smooth animation
                card.style.transition = 'all 0.3s ease';
            }
        });
    }
}

/**
 * Removes the search functionality and notification button
 */
function removeUnwantedElements() {
    
    // Keep the search box in properties page only
    const currentPath = window.location.pathname;
    const isPropertiesPage = currentPath.includes('properties.html');
    
    if (!isPropertiesPage) {
        const searchBox = document.querySelector('.search-box');
        if (searchBox) {
            searchBox.remove();
        }
    }
}


/**
 * Initializes and handles pagination functionality
 */
function initializePagination() {
    // Configuration
    const itemsPerPage = 5;
    const totalItems = parseInt(document.getElementById('total-items').textContent);
    const totalPages = Math.ceil(totalItems / itemsPerPage);
    
    // Elements
    const paginationNumbers = document.querySelector('.pagination-numbers');
    const prevButton = document.getElementById('prev-btn');
    const nextButton = document.getElementById('next-btn');
    const showingStart = document.getElementById('showing-start');
    const showingEnd = document.getElementById('showing-end');
    
    // Current page state
    let currentPage = 1;
    
    // Generate pagination buttons
    function generatePaginationButtons() {
        // Clear existing buttons
        paginationNumbers.innerHTML = '';
        
        // Determine range of pages to show
        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, startPage + 4);
        
        // Adjust start page if we're near the end
        if (endPage - startPage < 4) {
            startPage = Math.max(1, endPage - 4);
        }
        
        // Add first page button if not in range
        if (startPage > 1) {
            const firstPageBtn = createPageButton(1);
            paginationNumbers.appendChild(firstPageBtn);
            
            // Add ellipsis if there's a gap
            if (startPage > 2) {
                const ellipsis = document.createElement('span');
                ellipsis.className = 'pagination-ellipsis';
                ellipsis.textContent = '...';
                paginationNumbers.appendChild(ellipsis);
            }
        }
        
        // Add page buttons in the calculated range
        for (let i = startPage; i <= endPage; i++) {
            const pageButton = createPageButton(i);
            paginationNumbers.appendChild(pageButton);
        }
        
        // Add last page button if not in range
        if (endPage < totalPages) {
            // Add ellipsis if there's a gap
            if (endPage < totalPages - 1) {
                const ellipsis = document.createElement('span');
                ellipsis.className = 'pagination-ellipsis';
                ellipsis.textContent = '...';
                paginationNumbers.appendChild(ellipsis);
            }
            
            const lastPageBtn = createPageButton(totalPages);
            paginationNumbers.appendChild(lastPageBtn);
        }
    }
    
    // Create a page button with appropriate event listeners
    function createPageButton(pageNumber) {
        const button = document.createElement('button');
        button.className = 'pagination-btn' + (pageNumber === currentPage ? ' active' : '');
        button.textContent = pageNumber;
        
        button.addEventListener('click', () => {
            if (pageNumber !== currentPage) {
                goToPage(pageNumber);
            }
        });
        
        return button;
    }
    
    // Go to specific page
    function goToPage(pageNumber) {
        currentPage = pageNumber;
        
        // Update UI
        updateActiveButton();
        updateButtonStates();
        updateShowingInfo();
        
        // Simulate loading data for the current page
        loadPageData(currentPage);
    }
    
    // Update the active state of page buttons
    function updateActiveButton() {
        const buttons = paginationNumbers.querySelectorAll('.pagination-btn');
        buttons.forEach(button => {
            if (parseInt(button.textContent) === currentPage) {
                button.classList.add('active');
            } else {
                button.classList.remove('active');
            }
        });
    }
    
    // Update prev/next button states
    function updateButtonStates() {
        prevButton.disabled = currentPage === 1;
        nextButton.disabled = currentPage === totalPages;
    }
    
    // Update showing X to Y of Z text
    function updateShowingInfo() {
        const start = (currentPage - 1) * itemsPerPage + 1;
        const end = Math.min(currentPage * itemsPerPage, totalItems);
        
        showingStart.textContent = start;
        showingEnd.textContent = end;
    }
    
    // Simulates loading data for the current page
    function loadPageData(page) {
        // In a real application, this would fetch data from an API
        // For this demo, we'll just add a loading indicator
        
        const tableBody = document.querySelector('table tbody');
        if (tableBody) {
            // Show loading state
            tableBody.innerHTML = '<tr><td colspan="5" class="text-center">Loading properties...</td></tr>';
            
            // Simulate API delay
            setTimeout(() => {
                // Generate random property data for demo purposes
                let rows = '';
                const types = ['Apartment', 'House', 'Land', 'Villa', 'Restaurant'];
                const locations = ['Kathmandu', 'Lalitpur', 'Bhaktapur', 'Pokhara', 'Biratnagar', 'Chitwan'];
                const statuses = ['badge-sale', 'badge-rent', 'badge-pending', 'badge-active'];
                const statusTexts = ['For Sale', 'For Rent', 'Pending', 'Active'];
                
                const startIndex = (page - 1) * itemsPerPage;
                
                for (let i = 0; i < itemsPerPage; i++) {
                    // Skip if we exceed total items
                    if (startIndex + i >= totalItems) break;
                    
                    const propertyName = `Property ${startIndex + i + 1}`;
                    const type = types[Math.floor(Math.random() * types.length)];
                    const location = locations[Math.floor(Math.random() * locations.length)];
                    const price = Math.floor(Math.random() * 50000000) + 5000000;
                    const formattedPrice = `Rs. ${price.toLocaleString()}`;
                    const statusIndex = Math.floor(Math.random() * statuses.length);
                    
                    rows += `
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="${propertyName}">
                                    </div>
                                    <div>${propertyName} in ${location}</div>
                                </div>
                            </td>
                            <td>${type}</td>
                            <td>${location}</td>
                            <td>${formattedPrice}</td>
                            <td><span class="badge ${statuses[statusIndex]}">${statusTexts[statusIndex]}</span></td>
                        </tr>
                    `;
                }
                
                tableBody.innerHTML = rows;
            }, 500);
        }
    }
    
    // Add CSS styles for pagination ellipsis
    const style = document.createElement('style');
    style.textContent = `
        .pagination-ellipsis {
            display: inline-block;
            padding: 0.375rem 0.5rem;
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .text-center {
            text-align: center;
        }
    `;
    document.head.appendChild(style);
    
    // Set up event listeners for prev/next buttons
    prevButton.addEventListener('click', () => {
        if (currentPage > 1) {
            goToPage(currentPage - 1);
        }
    });
    
    nextButton.addEventListener('click', () => {
        if (currentPage < totalPages) {
            goToPage(currentPage + 1);
        }
    });
    
    // Initialize
    generatePaginationButtons();
    updateButtonStates();
    updateShowingInfo();
    loadPageData(currentPage);
}