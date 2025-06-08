import SwiftUI
import PhotosUI

struct BacktoYouView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showLostItemForm = false
    @State private var showFoundItemForm = false
    @State private var showStaffWarning = false
    
    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Lost your Item ?")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
     
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .opacity(0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
          
            VStack(spacing: 30) {
                Spacer()
                
               
                Image("lost")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 250)
                    .padding(.horizontal, 40)
                
                VStack(spacing: 8) {
                    Text("Report or Announce lost items on the campus.")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("Submit, view, and get notified—fast and easy!")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
        
                VStack(spacing: 16) {
                
                    Button(action: {
                        showLostItemForm = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.blue)
                            
                            Text("I Lost Something")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 4)
                        )
                        .cornerRadius(25)
                    }
                    

                    Button(action: {
                   
                        showStaffWarning = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.green)
                            
                            Text("Announce Found Item")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 4)
                        )
                        .cornerRadius(25)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            

        }
        .background(Color.white)
        .navigationBarHidden(true)
        .sheet(isPresented: $showLostItemForm) {
            LostItemFormView()
        }
        .sheet(isPresented: $showFoundItemForm) {
            FoundItemFormView()
        }
        .alert(isPresented: $showStaffWarning) {
            Alert(
                title: Text("Staff Only Feature"),
                message: Text("This feature only available for Office staff"),
                dismissButton: .default(Text("OK")) {

                    showFoundItemForm = true
                }
            )
        }
    }
}



struct LostItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var lastSeenLocation = ""
    @State private var contactInfo = ""
    @State private var selectedCategory = "Electronics"
    
    // Photo upload states
    @State private var selectedImages: [UIImage] = []
    @State private var showingImagePicker = false
    @State private var showingActionSheet = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    let categories = ["Electronics", "Clothing", "Books", "Accessories", "Documents", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                   
                    VStack(spacing: 8) {
                        Text("Report Lost Item")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Fill in the details to help others find your item")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                  
                    VStack(spacing: 20) {
                     
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Name")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter Here", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Photos (Optional)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text("Add photos to help others identify your item")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                           
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                
                                Button(action: {
                                    showingActionSheet = true
                                }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 24))
                                            .foregroundColor(.blue)
                                        
                                        Text("Add Photo")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                    .frame(height: 100)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    )
                                }
                                
                               
                                ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 100)
                                            .clipped()
                                            .cornerRadius(12)
                                        
                                        
                                        Button(action: {
                                            selectedImages.remove(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                                .background(Color.white)
                                                .clipShape(Circle())
                                        }
                                        .padding(4)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe your item in detail...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Last Seen Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., Library, Cafeteria, Lecture Hall 01", text: $lastSeenLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                  
                    Button(action: {
                        
                        submitLostItemReport()
                    }) {
                        Text("Submit Report")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Select Photo"),
                    message: Text("Choose how you'd like to add a photo"),
                    buttons: [
                        .default(Text("Camera")) {
                            imageSourceType = .camera
                            showingImagePicker = true
                        },
                        .default(Text("Photo Library")) {
                            imageSourceType = .photoLibrary
                            showingImagePicker = true
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(
                    selectedImages: $selectedImages,
                    sourceType: imageSourceType
                )
            }
        }
    }
    
    private func submitLostItemReport() {
        
        print("Submitting report with \(selectedImages.count) photos")
        
    
        presentationMode.wrappedValue.dismiss()
    }
}



struct LostItemFormView_Previews: PreviewProvider {
    static var previews: some View {
        LostItemFormView()
    }
}



struct FoundItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var foundLocation = ""
    @State private var contactInfo = ""
    @State private var selectedCategory = "Electronics"
    
    // Photo upload states
    @State private var selectedImages: [UIImage] = []
    @State private var showingImagePicker = false
    @State private var showingActionSheet = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    
    let categories = ["Electronics", "Clothing", "Books", "Accessories", "Documents", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Announce Found Item")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Help someone find their lost item")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 20) {
                      
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Found")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., iPhone 13, Blue Backpack", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Photos (Optional)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text("Add photos to help identify the found item")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                         
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                
                                Button(action: {
                                    showingActionSheet = true
                                }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 24))
                                            .foregroundColor(.green)
                                        
                                        Text("Add Photo")
                                            .font(.caption)
                                            .foregroundColor(.green)
                                    }
                                    .frame(height: 100)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.green.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    )
                                }
                                
                                ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 100)
                                            .clipped()
                                            .cornerRadius(12)
                                        
                                        
                                        Button(action: {
                                            selectedImages.remove(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                                .background(Color.white)
                                                .clipShape(Circle())
                                        }
                                        .padding(4)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe the item you found...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Found Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Where did you find this item?", text: $foundLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                   
                    Button(action: {
                      
                        submitFoundItemReport()
                    }) {
                        Text("Announce Found Item")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Select Photo"),
                    message: Text("Choose how you'd like to add a photo"),
                    buttons: [
                        .default(Text("Camera")) {
                            imageSourceType = .camera
                            showingImagePicker = true
                        },
                        .default(Text("Photo Library")) {
                            imageSourceType = .photoLibrary
                            showingImagePicker = true
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(
                    selectedImages: $selectedImages,
                    sourceType: imageSourceType
                )
            }
        }
    }
    
    private func submitFoundItemReport() {
      
        print("Submitting found item report with \(selectedImages.count) photos")
        

        presentationMode.wrappedValue.dismiss()
    }
}




struct LostAndFoundView_Previews: PreviewProvider {
    static var previews: some View {
        BacktoYouView()
    }
}
