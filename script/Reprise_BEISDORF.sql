--spécifique BEISDORF

DECLARE

@VAR_MATRI varchar(10),
@VAR_SIREN varchar(9),
@VAR_CEMP varchar(6),
@VAR_GCREF varchar(4),
@VAR_PERTB varchar(6),
@VAR_IMP01 varchar(50),
@VAR_PERDB  datetime,
@VAR_PRC01 varchar(255);

DECLARE Organigramme_cursor CURSOR FOR

select SIREN,Code,Matricule from organigramme
WHERE MATRICULE !=''
GROUP BY Matricule,SIREN,code

OPEN Organigramme_cursor;

FETCH NEXT FROM Organigramme_cursor
INTO @VAR_SIREN,@VAR_IMP01,@VAR_MATRI;
 
WHILE @@FETCH_STATUS = 0

BEGIN

    SELECT @VAR_CEMP=Employeur FROM EMPLOYEUR WHERE SIREN=@VAR_SIREN;
    SELECT TOP(1) @VAR_GCREF=GCREF FROM GENCONTRAT WHERE MATRI=@VAR_MATRI;
    SET @VAR_PERDB=01/01/1900;
    SET @VAR_PRC01='100.00';

	INSERT INTO IMPUTATIONANALYTIQUE
	VALUES (@VAR_MATRI,@VAR_CEMP,@VAR_GCREF,@VAR_PERDB,'',@VAR_IMP01,@VAR_PRC01);	

	FETCH NEXT FROM Organigramme_cursor
    INTO @VAR_SIREN,@VAR_IMP01,@VAR_MATRI;
	  	 
END

  
CLOSE Organigramme_cursor;  
DEALLOCATE Organigramme_cursor;  
GO  

DECLARE

@VAR_MATRICULE varchar(10),
@VAR_SIREN varchar(9),
@VAR_VEN_SECTION char(4),
@VAR_TRAVAILN1 char(3);

DECLARE Pag_cursor CURSOR FOR

select VEN_CODE,VEN_SIREN,VEN_SECTION from HR_SPRINT_REPRISEVENTILATIONANALYTIQUE
OPEN Pag_cursor;

FETCH NEXT FROM Pag_cursor
INTO @VAR_MATRICULE,@VAR_SIREN,@VAR_VEN_SECTION;
 
WHILE @@FETCH_STATUS = 0

BEGIN

    SELECT @VAR_TRAVAILN1=CC_CODE FROM PAG WHERE LEFT (CC_LIBELLE,4)=@VAR_VEN_SECTION;

    UPDATE HR_SPRINT_SALARIES SET PSA_TRAVAILN1=@VAR_TRAVAILN1 WHERE PSA_SALARIE=@VAR_MATRICULE AND PSA_SIREN=@VAR_SIREN

	FETCH NEXT FROM Pag_cursor
    INTO @VAR_MATRICULE,@VAR_SIREN,@VAR_VEN_SECTION;
	  	 
END

  
CLOSE Pag_cursor;  
DEALLOCATE Pag_cursor;  
GO  




