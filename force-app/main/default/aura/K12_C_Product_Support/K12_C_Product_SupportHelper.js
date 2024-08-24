({
                MAX_FILE_SIZE: 4 500 000, /* 6 000 000 * 3/4 to account for base64 */
    CHUNK_SIZE: 950 000, /* Use a multiple of 4 */
 
    save : function(component) {
      var fileInput = component.find("file").getElement();
        //alert('hi'+fileInput);
                var file = fileInput.files[0];
  
        if (file.size > this.MAX_FILE_SIZE) {
            alert('File size cannot exceed ' + this.MAX_FILE_SIZE + ' bytes.\n' +
                                  'Selected file size: ' + file.size);
                    return;
        }
       
        var fr = new FileReader();
 
        var self = this;
        fr.onload = function() {
            var fileContents = fr.result;
                    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
 
            fileContents = fileContents.substring(dataStart);
       
                    self.upload(component, file, fileContents);
        };
 
        fr.readAsDataURL(file);
    },
       
    upload: function(component, file, fileContents) {
        var fromPos = 0;
        var toPos = Math.min(fileContents.length, fromPos + this.CHUNK_SIZE);
                               
        // start with the initial chunk
        this.uploadChunk(component, file, fileContents, fromPos, toPos, '');  
    },
    
    uploadChunk : function(component, file, fileContents, fromPos, toPos, attachId) {
        var action = component.get("c.saveTheChunk");
        var chunk = fileContents.substring(fromPos, toPos);
                               //alert(attachId+'fileName'+file.name+'hi'+component.get("v.CaseId"));
        action.setParams({
            parentId: component.get("v.CaseId"),
            fileName: file.name,
            base64Data: encodeURIComponent(chunk),
            contentType: file.type,
            fileId: attachId
        });
      
        var self = this;
        action.setCallback(this, function(a) {
            attachId = a.getReturnValue();
           
            fromPos = toPos;
            toPos = Math.min(fileContents.length, fromPos + self.CHUNK_SIZE);   
            if (fromPos < toPos) {
                self.uploadChunk(component, file, fileContents, fromPos, toPos, attachId); 
            }
            window.location.reload();
        });
           
        $A.run(function() {
            $A.enqueueAction(action);
          
        });
       
    },
    Captcha : function(component,event,helper)
    {
        var alpha = new Array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
        var i;
       for (i=0;i<4;i++){
            var a = alpha[Math.floor(Math.random() * alpha.length)];
            var b = alpha[Math.floor(Math.random() * alpha.length)];
            var c = alpha[Math.floor(Math.random() * alpha.length)];
            var d = alpha[Math.floor(Math.random() * alpha.length)];
        }
        var code = a+b+c+d ;
        $("#Captcha").val(code);
    },
        evalCaptcha: function(component,event,helper)
                {
        var exicaptcha = $("#Captcha").val();
        var entcaptcha = $("#txtInput").val();
        if(exicaptcha === entcaptcha)
        {
            $("#captchasection").hide();
            return 1;
        }
        else
        {
            return 0;
        }
        }
})